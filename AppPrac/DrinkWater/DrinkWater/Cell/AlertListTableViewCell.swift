//
//  AlertListTableViewCell.swift
//  DrinkWater
//
//  Created by JunHeeJo on 11/23/21.
//

import UIKit
import UserNotifications

class AlertListTableViewCell: UITableViewCell {
    let userNotificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()
    
    @IBOutlet weak var ampmLabel: UILabel!
    @IBOutlet weak var tiemLabel: UILabel!
    @IBOutlet weak var alertSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func changeValueAlertSwitch(_ sender: UISwitch) {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              var alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else {
                  return
              }
        alerts[sender.tag].isOn = sender.isOn
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alerts), forKey: "alerts")
        
        if sender.isOn {
            self.userNotificationCenter.addNotificationRequest(by: alerts[sender.tag])
        } else {
            self.userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [alerts[sender.tag].id])
        }
    }
}
