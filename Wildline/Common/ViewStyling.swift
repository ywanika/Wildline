//
//  ViewStyling.swift
//  Wildline
//
//  Created by Anika Sharma on 12/2/25.
//

import UIKit

class ViewStyling: UIView {

}

extension UIView {
    
    /// Creates ui text field with green border
    /// textFieldPassword = createStyledTextField(placeholder: "Password")
    func createStyledTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor(red: 0.5, green: 0.75, blue: 0.5, alpha: 1.0).cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.layer.shadowColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 0.1).cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowRadius = 4
        textField.layer.shadowOpacity = 1.0
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    func createStyledPrimaryButton(title: String) -> UIButton{
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 0.35, alpha: 1.0) // Vibrant green
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        
        button.layer.shadowColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 0.3).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 1.0
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func createStyledSecondaryButton(title: String) -> UIButton{
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0.2, green: 0.6, blue: 0.35, alpha: 1.0).cgColor // Vibrant green
        button.setTitleColor(UIColor(red: 0.2, green: 0.6, blue: 0.35, alpha: 1.0), for: .normal)
        button.layer.cornerRadius = 12
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
