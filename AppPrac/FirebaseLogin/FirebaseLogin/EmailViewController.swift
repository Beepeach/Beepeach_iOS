//
//  EmailViewController.swift
//  FirebaseLogin
//
//  Created by JunHeeJo on 11/13/21.
//

import UIKit
import Firebase

class EmailViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nextButton.layer.cornerRadius = 30
        nextButton.isEnabled = false
        emailField.becomeFirstResponder()
        
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.isHidden = false
    }
    
    
    @IBAction func tapNext(_ sender: Any) {
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        
        // 신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007:
                    self.loginUser(with: email, password: password)
                default:
                    self.errorLabel.text = error.localizedDescription
                }
            } else {
                self.showMainVC()
            }
        }
    }
    
    private func showMainVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        mainVC.modalPresentationStyle = .fullScreen
        navigationController?.show(mainVC, sender: nil)
    }
    
    private func loginUser(with email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorLabel.text = error.localizedDescription
            } else {
                self.showMainVC()
            }
        }
    }
}


extension EmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailField.text == ""
        let isPasswordEmpty = passwordField.text == ""
        
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
