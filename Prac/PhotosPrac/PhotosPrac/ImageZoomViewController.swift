//
//  ImageZoomViewController.swift
//  PhotosPrac
//
//  Created by JunHeeJo on 10/27/21.
//

import UIKit
import Photos

class ImageZoomViewController: UIViewController {
    // MARK: Properties
    var asset: PHAsset?
    let imageManager: PHCachingImageManager = PHCachingImageManager()

    // MARK: @IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let asset = self.asset else { return }
        imageManager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFill, options: nil) { image, _ in
            self.imageView.image = image
        }
    }
}


// MARK: - UIScrollViewDelegate
extension ImageZoomViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
