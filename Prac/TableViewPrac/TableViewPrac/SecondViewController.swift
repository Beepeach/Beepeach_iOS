//
//  SecondViewController.swift
//  TableViewPrac
//
//  Created by JunHeeJo on 10/26/21.
//

import UIKit

class SecondViewController: UIViewController {
    // MARK: Properties
    var text: String?
    
    @IBOutlet weak var textLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.textLabel.text = self.text
    }
}
