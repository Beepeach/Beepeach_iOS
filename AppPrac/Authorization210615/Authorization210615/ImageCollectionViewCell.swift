//
//  ImageCollectionViewCell.swift
//  Authorization210615
//
//  Created by JunHee Jo on 2021/06/16.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.contentMode = .scaleAspectFill
    }
}
