//
//  SettingViewController.swift
//  NeonSignBoard
//
//  Created by JunHeeJo on 1/29/22.
//

import UIKit

protocol NeonSignBoardSettingDelegate: AnyObject {
    func neonSignBoard(_vc: UIViewController, didFinishSetting text: String?, with size: CGFloat, withTextColor textColor: UIColor, withBackgroundColor background: UIColor)
}


class SettingViewController: UIViewController {
    // MARK: Properties
    weak var delegate: NeonSignBoardSettingDelegate?
    var text: String?
    var textSize: CGFloat?
    var textColor: UIColor?
    var backgroundColor: UIColor?
    
    // MARK: @IBOutlet
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textSizeSlider: UISlider!
    @IBOutlet weak var textColorWell: UIColorWell!
    @IBOutlet weak var backgroundColorWell: UIColorWell!
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureColorWell()

        self.textView.text = text
        self.textSizeSlider.value = Float(textSize ?? 18.0)
    }
    
    private func configureColorWell() {
        configureTextColorWell()
        configureBackgroundColorWell()
    }
    
    private func configureTextColorWell() {
        self.textColorWell.backgroundColor = .systemBackground
        self.textColorWell.selectedColor = textColor
        self.textColorWell.title = "Text Color"
    }
    
    private func configureBackgroundColorWell() {
        self.backgroundColorWell.backgroundColor = .systemBackground
        self.backgroundColorWell.selectedColor = backgroundColor
        self.backgroundColorWell.title = "Background Color"
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveSetting()

        delegate?.neonSignBoard(
            _vc: self,
            didFinishSetting: text,
            with: textSize ?? 18.0,
            withTextColor: textColor ?? .black,
            withBackgroundColor: backgroundColor ?? .white
        )
    }
    
    private func saveSetting() {
        text = textView.text
        textSize = CGFloat(textSizeSlider.value)
        textColor = textColorWell.selectedColor
        backgroundColor = backgroundColorWell.selectedColor
    }
}


