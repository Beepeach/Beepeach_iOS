//
//  CodePresentViewController.swift
//  ScreenTransition
//
//  Created by JunHeeJo on 10/18/21.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func sendData(name: String)
}

class CodePresentViewController: UIViewController {
    var name: String?
    weak var delegate: SendDataDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.delegate?.sendData(name: "Present Beepeach")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = name {
            self.nameLabel.text = name
        }
    }
}
