//
//  ViewController.swift
//  TableViewPrac
//
//  Created by JunHeeJo on 10/26/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
    let names: [String] = ["Beepaech", "Peach", "SomSom", "Ogu", "Zelda", "Link"]
    let alphabet: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i"]
    var dates: [Date] = []
    
    let cellIdentifier: String = "cell"
    let customCellIdentifier: String = "customCell"
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter
    }()
    let timeFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.timeStyle = .medium
        
        return formatter
    }()
    
    // MARK: @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: @IBAction
    @IBAction func touchUpAddButton(_ sender: UIButton) {
        dates.append(Date())
        
        let lastIndexPath: IndexPath = IndexPath(item: dates.count - 1, section: 2)
        
        self.tableView.reloadSections(IndexSet(2...2), with: .automatic)
        self.tableView.scrollToRow(at: lastIndexPath, at: UITableView.ScrollPosition.top, animated: true)
    }
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return names.count
        case 1:
            return alphabet.count
        case 2:
            return dates.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
            
            let text: String = indexPath.section == 0 ? names[indexPath.row] : alphabet[indexPath.row]
            cell.textLabel?.text = text
            
            return cell
        } else {
            guard let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.customCellIdentifier, for: indexPath) as? CustomTableViewCell else {
                return CustomTableViewCell()
            }
            
            cell.textLabel?.text = self.dateFormatter.string(from: self.dates[indexPath.row])
            
            cell.leftLabel.text = dateFormatter.string(from: self.dates[indexPath.row])
            cell.rightLabel.text = timeFormatter.string(from: self.dates[indexPath.row])
            
            return cell
        }
    }
}


// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let text: String?
        
        switch section {
        case 0:
            text = "Name"
        case 1:
            text = "Alphabet"
        case 2:
            text = "Dates"
        default:
            text = ""
        }
        
        return text
    }
}
