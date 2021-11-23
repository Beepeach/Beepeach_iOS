//
//  AddAlertViewController.swift
//  DrinkWater
//
//  Created by JunHeeJo on 11/23/21.
//

import UIKit

class AddAlertViewController: UIViewController {
    var pickedDate: ((_ date: Date) -> Void)?

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tapCancelBarButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSaveBarButton(_ sender: Any) {
        pickedDate?(datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
}
