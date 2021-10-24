//
//  ViewController.swift
//  DatePicker
//
//  Created by JunHeeJo on 10/24/21.
//

import UIKit

class ViewController: UIViewController {
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
//        formatter.timeZone = TimeZone.init(identifier: "ko_kr")
//        formatter.dateStyle = .long
//        formatter.timeStyle = .long
        
        formatter.dateFormat = "yyyy MM dd HH:mm:ss"
        return formatter
    }()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func didDatePikcerValueChanged(_ sender: UIDatePicker) {
        print("value changed")
        let date: Date = sender.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        self.dateLabel.text = dateString
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datePicker.addTarget(self, action: #selector(self.didDatePikcerValueChanged(_:)), for: .valueChanged)
    }
}

