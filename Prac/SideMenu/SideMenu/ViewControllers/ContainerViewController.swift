//
//  ViewController.swift
//  SideMenu
//
//  Created by JunHeeJo on 2/9/22.
//

import UIKit



class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opend
        case closed
    }
    
    private var menuState: MenuState = .closed

    let menuVC: MenuViewController = {
        guard let menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else {
            return MenuViewController()
        }
        
        return menuVC
    }()
    
    let homeNavC: UINavigationController = {
        guard let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController else {
            return UINavigationController(rootViewController: HomeViewController())
        }
        
        return nav
    }()
    
    lazy var homeVC: HomeViewController = homeNavC.topViewController as? HomeViewController ?? HomeViewController()
    
    lazy var settingsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVCs()
    }
    
    private func addChildVCs() {
        menuVC.delegate = self
        addChild(menuVC)
        menuVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 100, height: self.view.frame.height)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)

        homeVC.delegate = self
        addChild(homeNavC)
        view.addSubview(homeNavC.view)
        homeNavC.didMove(toParent: self)
    }
}


extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect() {
        toggleMenu(completion: nil)
//            [weak self] in
//            guard  let strongSelf = self,
//                   let vc = self?.settingsVC else {
//                return
//            }
//            self?.addChild(vc)
//            self?.homeNavC.view.addSubview(vc.view)
//            vc.didMove(toParent: strongSelf)
        self.addSettings()
    }
    
    func addSettings() {
        homeVC.addChild(settingsVC)
        homeVC.view.addSubview(settingsVC.view)
        settingsVC.didMove(toParent: homeVC)
    }
    
    func resetToHome() {
        settingsVC.view.removeFromSuperview()
        settingsVC.didMove(toParent: nil)
        // homeVC.title = "Home"
    }
}


extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.homeNavC.view.frame.origin.x = self.homeNavC.view.frame.size.width - 100
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opend
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }

        case .opend:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.homeNavC.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }

        }
    }
}

