//
//  AddAlertViewController.swift
//  DrinkWater
//
//  Created by JunHeeJo on 11/23/21.
//

import UIKit

class AddAlertViewController: UIViewController {
    // MARK: Properties
    var pickedDate: ((_ date: Date) -> Void)?

    // MARK: @IBOutlet
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: @IBAction
    @IBAction func tapCancelBarButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSaveBarButton(_ sender: Any) {
        pickedDate?(datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
}
