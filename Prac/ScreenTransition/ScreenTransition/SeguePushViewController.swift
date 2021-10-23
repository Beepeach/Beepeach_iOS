//
//  SeguePushViewController.swift
//  ScreenTransition
//
//  Created by JunHeeJo on 10/18/21.
//

import UIKit

class SeguePushViewController: UIViewController {
    var name: String?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func tapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        // self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    // MARK: ViewLiftCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SeguePushViewController", #function)
        
        if let name = name {
            self.nameLabel.text = name
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SeguePushViewController", #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("SeguePushViewController", #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("SeguePushViewController", #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("SeguePushViewController", #function)
    }
}
