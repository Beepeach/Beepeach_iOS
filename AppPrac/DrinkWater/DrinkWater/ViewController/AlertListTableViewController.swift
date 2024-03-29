//
//  AlertListTableViewController.swift
//  DrinkWater
//
//  Created by JunHeeJo on 11/23/21.
//

import UIKit
import UserNotifications

class AlertListTableViewController: UITableViewController {
    // MARK: Properties
    var alerts: [Alert] = []
    let userNotificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let alertCell = UINib(nibName: "AlertListTableViewCell", bundle: nil)
        tableView.register(alertCell, forCellReuseIdentifier: "AlertListTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.alerts = getAlertListFromUserDefaults()
    }
    
    private func getAlertListFromUserDefaults() -> [Alert] {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              let alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else {
                  return []
              }
        
        return alerts
    }
    
    // MARK: @IBAction
    @IBAction func tapAddAlertButton(_ sender: UIBarButtonItem) {
        guard let addAlertVC = storyboard?.instantiateViewController(withIdentifier: "AddAlertViewController") as? AddAlertViewController else {
            return
        }
        
        addAlertVC.pickedDate = { [weak self] date in
            guard let self = self else { return }
            
            var alertList = self.getAlertListFromUserDefaults()
            let newAlert = Alert(date: date, isOn: true)
            
            alertList.append(newAlert)
            alertList.sort { $0.date < $1.date }
            
            self.alerts = alertList
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alerts), forKey: "alerts")
            self.userNotificationCenter.addNotificationRequest(by: newAlert)
            
            self.tableView.reloadData()
        }
        
        self.present(addAlertVC, animated: true, completion: nil)
    }
}


// MARK: - UITableViewDataSource
extension AlertListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlertListTableViewCell", for: indexPath) as? AlertListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.alertSwitch.isOn = alerts[indexPath.row].isOn
        cell.tiemLabel.text = alerts[indexPath.row].hourAndMin
        cell.ampmLabel.text = alerts[indexPath.row].ampm
        cell.alertSwitch.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "💦물 마실 시간"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


// MARK: - UITableViewDelegate
extension AlertListTableViewController {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            // Notification 삭제
            userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [alerts[indexPath.row].id])
            self.alerts.remove(at: indexPath.row)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alerts), forKey: "alerts")
            self.tableView.reloadData()
        default:
            break
        }
    }
}
