//
//  SettingViewController.swift
//  LEDBoard
//
//  Created by JunHeeJo on 10/18/21.
//

import UIKit

protocol LEDBoardSettingDelegate: NSObject {
    func ledBoard(_ vc: UIViewController, willDisplay text: String?, withTextColor textColor: UIColor, withBackgroundColor backgroundColor: UIColor)
}

class SettingViewController: UIViewController {
    // MARK: Properies
    weak var delegate: LEDBoardSettingDelegate?
    var textColor: UIColor = .yellow
    var backgroundColor: UIColor = .black
    var ledText: String?

    // MARK: @IBOutlet
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }
    
    private func configureView() {
        if let ledText = self.ledText {
            self.textField.text = ledText
        }
        self.changeTextColor(color: self.textColor)
        self.changeBackgroundColor(color: self.backgroundColor)
    }
    
    // MARK: @IBAction
    @IBAction func tapTextColorButton(_ sender: UIButton) {
        switch sender {
        case self.yellowButton:
            self.changeTextColor(color: .yellow)
            self.textColor = .yellow
        case self.purpleButton:
            self.changeTextColor(color: .purple)
            self.textColor = .purple
        case self.greenButton:
            self.changeTextColor(color: .green)
            self.textColor = .green
        default:
            break
        }
    }
    
    @IBAction func tapBackgroundColorButton(_ sender: UIButton) {
        switch sender {
        case self.blackButton:
            self.changeBackgroundColor(color: .black)
            self.backgroundColor = .black
        case self.blueButton:
            self.changeBackgroundColor(color: .blue)
            self.backgroundColor = .blue
        case self.orangeButton:
            self.changeBackgroundColor(color: .orange)
            self.backgroundColor = .orange
        default:
            break
        }
    }
    
    @IBAction func tapSaveButton(_ sender: UIButton) {
        self.delegate?.ledBoard(
            self,
            willDisplay: self.textField.text,
            withTextColor: self.textColor,
            withBackgroundColor: self.backgroundColor
        )
        
        self.navigationController?.popViewController(animated: true)
    }
    
    private func changeTextColor(color: UIColor) {
        self.yellowButton.alpha = color == .yellow ? 1: 0.2
        self.purpleButton.alpha = color == .purple ? 1 : 0.2
        self.greenButton.alpha = color == .green ? 1 : 0.2
    }
    
    private func changeBackgroundColor(color: UIColor) {
        self.blackButton.alpha = color == .black ? 1 : 0.2
        self.blueButton.alpha = color == .blue ? 1 : 0.2
        self.orangeButton.alpha = color == .orange ? 1 : 0.2
    }
}
