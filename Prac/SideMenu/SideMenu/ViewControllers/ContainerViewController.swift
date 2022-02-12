//
//  ViewController.swift
//  SideMenu
//
//  Created by JunHeeJo on 2/9/22.
//

import UIKit

// TODO: - 메뉴를 누르면서 빠르게 trash를 선택하면 

class ContainerViewController: UIViewController {
    // MARK: Enum
    enum MenuState {
        case opend
        case closed
    }
    
    // MARK: Properties
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
    
    // MARK: VCLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVCs()
    }
    
    private func addChildVCs() {
        addMenuVC()
        addHomeNavC()
    }
    
    private func addMenuVC() {
        menuVC.delegate = self
        addChild(menuVC)
        menuVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 100, height: self.view.frame.height)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
    }
    
    private func addHomeNavC() {
        homeVC.delegate = self
        addChild(homeNavC)
        view.addSubview(homeNavC.view)
        homeNavC.didMove(toParent: self)
    }
}


// MARK: - MenuViewControllerDelegate
extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(_ vc: MenuViewController, mainMenu: MenuViewController.MenuOptions) {
        switch mainMenu {
        case .home:
            resetToHome()
            homeNavC.popToRootViewController(animated: true)
        case .settings:
            performSegue(mainMenu: mainMenu.rawValue)
        case .trash:
            performSegue(mainMenu: mainMenu.rawValue)
        }
        toggleMenu(completion: nil)
    }
    
    func didSelect(_ vc: MenuViewController, subMenu: String) {
        toggleMenu(completion: nil)
        showVC(subMenu: subMenu)
    }
    
    private func performSegue(mainMenu: String) {
        let segueID: String = "to" + mainMenu
        homeVC.performSegue(withIdentifier: segueID, sender: nil)
    }
    
    private func resetToHome() {
        if !homeVC.children.isEmpty {
            guard let vc = homeVC.children.first as? HomeViewController else {
                return
            }
            vc.view.removeFromSuperview()
            vc.removeFromParent()
            homeVC.title = "Home"
            print("DeleteVC")
        }
    }
    
    private func showVC(subMenu: String) {
        if homeVC.children.isEmpty {
            addVC(subMenu)
        } else {
           replaceVC(subMenu)
        }
    }
    
    private func addVC(_ subMenu: String) {
        guard let subMenuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
            return
        }
        homeVC.addChild(subMenuVC)
        homeVC.view.addSubview(subMenuVC.view)
        subMenuVC.didMove(toParent: homeVC)
        homeVC.title = subMenu
        subMenuVC.textLabel.text = subMenu
        print("AddVC")
    }
    
    private func replaceVC(_ subMenu: String) {
        guard let subMenuVC = homeVC.children.first as? HomeViewController else {
            return
        }
        homeVC.title = subMenu
        subMenuVC.textLabel.text = subMenu
        print("Replace VC")
    }
}


// MARK: - HomeViewControllerDelegate
extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    private func toggleMenu(completion: (() -> Void)?) {
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

