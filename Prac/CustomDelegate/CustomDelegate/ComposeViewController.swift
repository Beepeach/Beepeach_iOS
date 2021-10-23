//
//  ComposeViewController.swift
//  CustomDelegate
//
//  Created by JunHeeJo on 10/18/21.
//

import UIKit

class ComposeViewController: UIViewController {
    // MARK: Properties
    var delegate: PopDelegate?
    
    // MARK: @IBOutlet
    @IBOutlet weak var inputField: UITextField!
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.composer(self, didInput: inputField.text)
    }
}
