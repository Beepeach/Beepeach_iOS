//
//  SeguePushViewController.swift
//  ScreenTransition
//
//  Created by JunHeeJo on 10/18/21.
//

import UIKit

class SeguePushViewController: UIViewController {
    
    @IBAction func tapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        // self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    // MARK: ViewLiftCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SeguePushViewController", #function)
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
