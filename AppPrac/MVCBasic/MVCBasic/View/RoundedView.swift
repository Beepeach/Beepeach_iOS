//
//  RoundedView.swift
//  MVCBasic
//
//  Created by JunHeeJo on 1/25/22.
//

import UIKit

@IBDesignable
class RoundedView: UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
        }
    }
}
