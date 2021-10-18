//
//  ViewController.swift
//  LEDBoard
//
//  Created by JunHeeJo on 10/18/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: @IBOutlet
    @IBOutlet weak var contentsLabel: UILabel!
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentsLabel.textColor = .yellow
    }
    
    // MARK: Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingViewController = segue.destination as? SettingViewController {
            settingViewController.delegate = self
            settingViewController.ledText = self.contentsLabel.text
            settingViewController.textColor = self.contentsLabel.textColor
            settingViewController.backgroundColor = self.view.backgroundColor ?? . black
        }
    }
}

// MARK: - LEDBoardSettingDelegate
extension ViewController: LEDBoardSettingDelegate {
    func ledBoard(_ vc: UIViewController, willDisplay text: String?, withTextColor textColor: UIColor, withBackgroundColor backgroundColor: UIColor) {
        if let text = text {
            self.contentsLabel.text = text
        }
        
        self.contentsLabel.textColor = textColor
        self.view.backgroundColor = backgroundColor
    }
}
