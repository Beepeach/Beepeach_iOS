//
//  HomeViewController.swift
//  SideMenu
//
//  Created by JunHeeJo on 2/9/22.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

class HomeViewController: UIViewController {
    // MARK: Properties
    weak var delegate: HomeViewControllerDelegate?
    
    // MARK: @IBOutlet
    @IBOutlet weak var textLabel: UILabel!
    
    // MARK: VCLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: @IBAction
    @IBAction func tapMenuButton(_ sender: Any) {
        delegate?.didTapMenuButton()
    }
}
