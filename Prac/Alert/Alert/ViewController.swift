//
//  ViewController.swift
//  Alert
//
//  Created by JunHeeJo on 11/1/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: @IBAction
    @IBAction func touchUpShowAlertButton(_ sender: UIButton) {
        self.showAlertController(style: .alert)
    }

    @IBAction func touchUpShowActionSheetButton(_ sender: UIButton) {
        self.showAlertController(style: .actionSheet)
    }
    
    private func showAlertController(style: UIAlertController.Style) {
        let alertController: UIAlertController
        alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: style)
        
        let okAction: UIAlertAction
        okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            print("OK pressed")
            
            guard let textField = alertController.textFields?.first else { return }
            print(textField.text ?? "No input")
        })
        
        // Cancel은 controller에 1개만 존재해야한다.
        let cancelAction: UIAlertAction
        cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        let handler: (UIAlertAction) -> Void
        handler = { (action: UIAlertAction) in
            print("action pressed \(action.title ?? "")")
        }
        
        let someAction: UIAlertAction
        someAction = UIAlertAction(title: "Some", style: .destructive, handler: handler)
        
        let anotehrAction: UIAlertAction
        anotehrAction = UIAlertAction(title: "Another", style: .cancel, handler: handler)
        
        alertController.addAction(someAction)
        alertController.addAction(anotehrAction)
        
        // TextField는 Alert에서만 사용이 가능하다.
        /*
        alertController.addTextField { (field: UITextField) in
            field.placeholder = "입력해보세요."
            field.textColor = .red
        }
        */
        
        self.present(alertController, animated: true) {
            print("AlertController show")
        }
    }
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

