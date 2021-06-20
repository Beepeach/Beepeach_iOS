//
//  ViewController.swift
//  Authorization210615
//
//  Created by JunHee Jo on 2021/06/15.
//

import UIKit
import Photos

class ViewController: UIViewController {
    // MARK: Property
    private var cellIdentifier: String = "cell"
    private var selectedImages: [CustomPHAsset] = []

    // MARK: @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Method
    public func setSelectedImages(images: [CustomPHAsset]) {
        self.selectedImages = images
    }
    
    //MARK: @IBAction
    @IBAction func unwindToViewController(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        NotificationCenter.default.addObserver(forName: .didSelectImage, object: nil, queue: .main) { noti in
            self.collectionView.reloadData()
            print(#function)
        }
    }

}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? SelectedImageCollectionViewCell else { return UICollectionViewCell()
        }
        
        let asset = selectedImages[indexPath.item].getAsset()
        let options = PHImageRequestOptions()
        options.deliveryMode = .opportunistic
        
        PHImageManager.default().requestImage(for: asset, targetSize: cell.bounds.size, contentMode: .aspectFill, options: options) { image, _ in
            
            guard let image = image else { return }
            
            cell.selectedImage.image = image
        }
        
        PHCachingImageManager.default().requestImage(for: asset, targetSize: cell.bounds.size, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
                guard let image = image else { return }
            cell.selectedImage.image = image
        })
        
        return cell
    }
}
