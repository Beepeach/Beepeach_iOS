//
//  IntroViewController.swift
//  FloClone
//
//  Created by JunHeeJo on 12/4/21.
//

import UIKit

class IntroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "SegueToHomeFromIntro", sender: self)
        }
    }
}
