//
//  CustomTableViewCell.swift
//  TableViewPrac
//
//  Created by JunHeeJo on 10/26/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    // MARK: @IBOutlet
    @IBOutlet var leftLabel: UILabel!
    @IBOutlet var rightLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
