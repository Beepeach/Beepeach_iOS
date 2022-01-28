//
//  DetailDateViewController.swift
//  CustomCalendar
//
//  Created by JunHee Jo on 2021/07/08.
//

import UIKit

class DetailDateViewController: UIViewController {
    var date: Date?
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        navigationItem.title = dateFormatter.string(from: date ?? Date())
    }
}
