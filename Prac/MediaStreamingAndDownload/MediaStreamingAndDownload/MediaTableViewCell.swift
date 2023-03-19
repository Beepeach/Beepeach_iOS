//
//  MediaTableViewCell.swift
//  MediaStreamingAndDownload
//
//  Created by JunHeeJo on 3/19/23.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
    static let identifier: String = "MediaTableViewCell"

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
