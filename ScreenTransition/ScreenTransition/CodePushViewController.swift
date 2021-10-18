//
//  CodePushViewController.swift
//  ScreenTransition
//
//  Created by JunHeeJo on 10/18/21.
//

import UIKit

class CodePushViewController: UIViewController {
    var name: String?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = name {
            self.nameLabel.text = name
        }
    }
}
