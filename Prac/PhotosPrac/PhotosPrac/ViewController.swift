//
//  ViewController.swift
//  PhotosPrac
//
//  Created by JunHeeJo on 10/27/21.
//

import UIKit
import Photos

class ViewController: UIViewController {
    // MARK: Properties
    let cellIdentifier: String = "cell"
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    // MARK: @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: CustomFunction
    func requestCollection() {
        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        guard let cameraRollColletion = cameraRoll.firstObject else {
            return
        }
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollColletion, options: fetchOptions)
    }
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("허용")
            self.requestCollection()
        case .denied:
            print("거절")
        case .notDetermined:
            print("결정하지 않음")
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    print("허용함")
                    self.requestCollection()
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                    }
                case .denied:
                    print("거절함")
                default:
                    break
                }
            }
        case .restricted:
            print("제한")
        case .limited:
            print("제한적 사용")
        @unknown default:
            break
        }
        
        PHPhotoLibrary.shared().register(self)
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextVC: ImageZoomViewController = segue.destination as? ImageZoomViewController else {
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else { return }
        
        guard let index: IndexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        nextVC.asset = self.fetchResult[index.row]
    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let asset: PHAsset = fetchResult.object(at: indexPath.row)
        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 30, height: 30), contentMode: .aspectFill, options: nil) { image, _ in
            cell.imageView?.image = image
        }
        
        return cell
    }
}


// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let asset: PHAsset = self.fetchResult[indexPath.row]
            
            PHPhotoLibrary.shared().performChanges ({
                PHAssetChangeRequest.deleteAssets([asset] as NSArray)
            }, completionHandler: nil)
        }
    }
}


// MARK: - PHPhotoLibraryChangeObserver
extension ViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: fetchResult) else {
            return
        }
        
        fetchResult = changes.fetchResultAfterChanges
        
        OperationQueue.main.addOperation {
            self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
        }
    }
}
