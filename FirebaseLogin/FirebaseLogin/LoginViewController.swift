//
//  LoginViewController.swift
//  FirebaseLogin
//
//  Created by JunHeeJo on 11/13/21.
//

import UIKit
import GoogleSignIn
import AuthenticationServices
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailLoginButton, googleLoginButton, appleLoginButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    
    @IBAction func tapGoogleLogin(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func tapAppleLogin(_ sender: Any) {
    }
}


extension LoginViewController: ASAuthorizationControllerDelegate {
    
}
