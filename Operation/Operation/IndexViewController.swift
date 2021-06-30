//
//  IndexViewController.swift
//  Operation
//
//  Created by JunHee Jo on 2021/06/30.
//

import UIKit

class IndexViewController: UIViewController {
    // MARK: Properties
    private let cellID: String = "cell"
    private let index: [String] = [
        "Operation",
        "Dependency"
    ]
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


// MARK: - UITableViewDataSource
extension IndexViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return index.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath)
        
        cell.textLabel?.text = index[indexPath.row]
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension IndexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: index[indexPath.row]) else { return }
        
        vc.navigationItem.title = index[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
