//
//  ViewController.swift
//  UIView
//
//  Created by JunHeeJo on 10/20/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - View Tagging Example
    @IBAction func changeColor(_ sender: UIButton) {
        if let target = view.viewWithTag(100) {
            target.backgroundColor = .black
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - View create with code
        let frame: CGRect = CGRect(x: 100, y: 100, width: 200, height: 200)
        
        let customView: UIView = UIView(frame: frame)
        customView.backgroundColor = .purple
        
        view.addSubview(customView)
    }
}

