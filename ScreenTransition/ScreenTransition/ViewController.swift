//
//  ViewController.swift
//  ScreenTransition
//
//  Created by JunHeeJo on 10/18/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: @IBAction
    @IBAction func tapCodePushButton(_ sender: UIButton) {
        guard let viewController: UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePushViewController") else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func tapCodePresentButton(_ sender: UIButton) {
        guard let viewController: UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePresentViewController") else { return }
        
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
}

