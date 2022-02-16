//
//  CustomCollectionViewCell.swift
//  CellDelegate
//
//  Created by JunHeeJo on 2/16/22.
//

import UIKit

protocol CustomCollectionViewCellDelegate: AnyObject {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
}

class CustomCollectionViewCell: UICollectionViewCell {
    weak var delegate: CustomCollectionViewCellDelegate?
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
}

extension CustomCollectionViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let delegate = delegate {
            return delegate.textFieldShouldReturn(textField)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let finalString = getFinalString(range: range, string: string)
        
        textLabel.text = finalString
        
        return true
    }
    
    private func getFinalString(range: NSRange, string: String) -> String {
        guard let text = firstTextField.text else {
            return ""
        }
        
        let nsText = text as NSString
        let finalString = nsText.replacingCharacters(in: range, with: string)
        
        return finalString
    }
}
