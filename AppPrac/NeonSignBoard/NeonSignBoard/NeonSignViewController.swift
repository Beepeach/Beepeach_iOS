//
//  NeonSignViewController.swift
//  NeonSignBoard
//
//  Created by JunHeeJo on 1/29/22.
//

import UIKit

class NeonSignViewController: UIViewController {
    // MARK: @IBOutlet
    @IBOutlet weak var textLabel: UILabel!
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingViewController else {
            return
        }
        
        configureSettingVC(settingVC)
    }
    
    private func configureSettingVC(_ vc: SettingViewController) {
        vc.delegate = self
        
        vc.text = textLabel.text
        vc.textSize = textLabel.font.pointSize
        vc.textColor = textLabel.textColor
        vc.backgroundColor = view.backgroundColor
    }
}


extension NeonSignViewController: NeonSignBoardSettingDelegate {
    func neonSignBoard(_vc: UIViewController, didFinishSetting text: String?, with size: CGFloat, withTextColor textColor: UIColor, withBackgroundColor background: UIColor) {
        configureTextLabel(text: text, size: size, color: textColor)
        view.backgroundColor = background
    }
    
    private func configureTextLabel(text: String?, size: CGFloat, color: UIColor) {
        textLabel.text = text
        textLabel.font = UIFont.systemFont(ofSize: size, weight: .regular)
        textLabel.textColor = color
    }
}
