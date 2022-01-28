//
//  ViewController.swift
//  StoryboardPrac
//
//  Created by JunHeeJo on 12/15/21.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func tapModalToCode(_ sender: Any) {
        let secondStoryboard = UIStoryboard(name: "Second", bundle: .main)
        // let secondStoryboard = UIStoryboard(name: "Second", bundle: nil)
        
        let secondVC = secondStoryboard.instantiateViewController(withIdentifier: "SecondViewControlle")
        //guard let secondVC = secondStoryboard.instantiateInitialViewController() else { return }
        
        present(secondVC, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

