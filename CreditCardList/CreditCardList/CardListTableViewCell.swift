//
//  CardListTableViewCell.swift
//  CreditCardList
//
//  Created by JunHeeJo on 11/16/21.
//

import UIKit

class CardListTableViewCell: UITableViewCell {
    // MARK: @IBOutlet
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var promotionLabel: UILabel!
    @IBOutlet weak var cardNameLabel: UILabel!
    
    // MARK: ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
