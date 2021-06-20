//
//  PickerViewController.swift
//  Authorization210615
//
//  Created by JunHee Jo on 2021/06/16.
//

import UIKit
import Photos

class PickerViewController: UIViewController {
    //MARK: Properties
    private let cellIdentifier: String = "cell"
    private var allImages: PHFetchResult<PHAsset>? = nil
    private var allCollectionList: PHFetchResult<PHCollection>? = nil
    private var selectedImages: [CustomPHAsset] = []
    private var imageCount: Int = 0
    
    // MARK: @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: @IBAction
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // MARK: Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ViewController {
            destination.setSelectedImages(images: selectedImages)
            NotificationCenter.default.post(name: .didSelectImage, object: nil)
        }
    }
    
    func sendImage() {
        
    }
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.allowsMultipleSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = .zero
            layout.minimumLineSpacing = .zero
            layout.sectionInset = .zero
        }
        
        let allPhotosOptions: PHFetchOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        allImages = PHAsset.fetchAssets(with: allPhotosOptions)
        allCollectionList = PHCollectionList.fetchTopLevelUserCollections(with: nil)
    }
}


// MARK: - UICollectionViewDataSource
extension PickerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? ImageCollectionViewCell else {
             return UICollectionViewCell()
        }
        
        guard let asset = allImages?.object(at: indexPath.row) else { return UICollectionViewCell() }
        
        PHCachingImageManager.default().requestImage(for: asset, targetSize: cell.bounds.size, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
                guard let image = image else { return }
                cell.imageView.image = image
        })
        
        return cell
    }
}


// MARK: - UICollectionViewDelegate
extension PickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let maxImageCount: Int = 5
        
        return imageCount >= maxImageCount ? false : true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else { return }
        
        if let asset = allImages?.object(at: indexPath.row) {
            // marking
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.systemRed.cgColor
            cell.imageView.tag = indexPath.row
            
            imageCount += 1
            
            selectedImages.append(
                CustomPHAsset(asset: asset, indexPath: indexPath)
            )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else { return }
        
        cell.layer.borderWidth = .zero
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.imageView.tag = 0
        
        if let deletedIndex = selectedImages.firstIndex(where: { $0.getIndexPath() == indexPath }) {
            imageCount -= 1
            selectedImages.remove(at: deletedIndex)
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension PickerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize.zero
        }
        
        let expectedHorizonCellCount: CGFloat = 3
        let expectedVerticalCellCount: CGFloat = 5
        
        let otherHorizonInset = calculateOtherHorizonInset(layout: layout, cellCount: expectedHorizonCellCount)
        let otherVerticalInset = calculateOtherVerticalInset(layout: layout, cellCount: expectedVerticalCellCount)
     
        let collectionViewWidth: CGFloat = collectionView.bounds.width
        let collectionViewHeight: CGFloat = collectionView.bounds.height + collectionView.bounds.origin.y
        
        let expectedCellWidth: CGFloat = (collectionViewWidth - otherHorizonInset) / expectedHorizonCellCount
        let expectedCellHeight: CGFloat = (collectionViewHeight - otherVerticalInset) / expectedVerticalCellCount
        
        return CGSize(width: expectedCellWidth.rounded(.down), height: expectedCellHeight.rounded(.down))
    }
    
    private func calculateOtherHorizonInset(layout: UICollectionViewFlowLayout, cellCount: CGFloat) -> CGFloat {
        let horizonSectionInset: CGFloat = layout.sectionInset.left + layout.sectionInset.right
        
        let otherHorizonInset: CGFloat = horizonSectionInset + (layout.minimumInteritemSpacing * (cellCount - 1))
        
        return otherHorizonInset
    }
    
    private func calculateOtherVerticalInset(layout: UICollectionViewFlowLayout, cellCount: CGFloat) -> CGFloat {
        let verticalSectionInset: CGFloat = layout.sectionInset.top + layout.sectionInset.bottom
        
        let otherVerticalInset: CGFloat = verticalSectionInset + (layout.minimumLineSpacing * (cellCount - 1))

        return otherVerticalInset
    }
}
