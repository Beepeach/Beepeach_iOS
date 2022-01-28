//
//  RoundButton.swift
//  Calculator
//
//  Created by JunHeeJo on 10/20/21.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
}
