//
//  ViewController.swift
//  CAGradientLayer
//
//  Created by JunHeeJo on 2/4/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.setGradationBackground()
    }
}

extension UIView {
    func setGradationBackground() {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        
        gradientLayer.colors = [
            UIColor(red: 0.9654200673, green: 0.1590853035, blue: 0.2688751221, alpha: 1).cgColor,
            UIColor(red: 0.7559037805, green: 0.1139892414, blue: 0.1577021778, alpha: 1).cgColor
        ]
        
        gradientLayer.locations = [0.0, 1.0]
        
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        // gradientLayer.type = .conic
        
        layer.addSublayer(gradientLayer)
    }
}

