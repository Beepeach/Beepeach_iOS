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
    
    weak var delegate: HomeViewControllerDelegate?
    
    @IBAction func tapMenuButton(_ sender: Any) {
        delegate?.didTapMenuButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
