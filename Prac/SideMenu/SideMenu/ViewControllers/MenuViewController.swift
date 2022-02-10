//
//  MenuViewController.swift
//  SideMenu
//
//  Created by JunHeeJo on 2/9/22.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(_ vc: MenuViewController, mainMenu: MenuViewController.MenuOptions)
    
    func didSelect(_ vc: MenuViewController, subMenu: String)
}


class MenuViewController: UIViewController {
    // MARK: Enum
    enum MenuOptions: String, CaseIterable {
        case Home
        case Trash
        case Settings
    }
    
    // MARK: Properties
    private var subMenus: [String] = [
        "etc",
        "etc2",
        "etc3"
    ]
    weak var delegate: MenuViewControllerDelegate?
    
    // MARK: VCLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: @IBActions
    @IBAction func tapHome(_ sender: UIButton) {
        delegate?.didSelect(self, mainMenu: .Home)
    }
    @IBAction func tapTrash(_ sender: UIButton) {
        delegate?.didSelect(self, mainMenu: .Trash)
    }
    @IBAction func tapSettings(_ sender: UIButton) {
        delegate?.didSelect(self, mainMenu: .Settings)
    }
}


// MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subMenus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = subMenus[indexPath.row]
        
        return cell
    }
}


// MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subMenu = subMenus[indexPath.row]
        delegate?.didSelect(self, subMenu: subMenu)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
