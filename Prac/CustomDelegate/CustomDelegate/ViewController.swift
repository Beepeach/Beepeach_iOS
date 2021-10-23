//
//  ViewController.swift
//  CustomDelegate
//
//  Created by JunHeeJo on 10/18/21.
//

import UIKit

class ViewController: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var dataLabel: UILabel!
        
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ComposeViewController {
            vc.delegate = self
        }
    }
}


// MARK: - PopDelegate
extension ViewController: PopDelegate {
    func composer(_ vc: UIViewController, didInput value: String?) {
        dataLabel.text = value
    }
}
