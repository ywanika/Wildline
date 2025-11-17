//
//  RegisterViewController.swift
//  Final Project
//
//  Created by Student on 11/16/25.
//

import UIKit

class RegisterViewController: UIViewController {

    var registerView = RegisterView()
    var selectedType: String = ""
    
    override func loadView() {
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        title = "Register"
        
        registerView.buttonSelectType.menu = getMenuTypes()

        // Do any additional setup after loading the view.
    }
    
    @objc func onSelectTypeButtonTapped() {
        
    }

    func getMenuTypes() -> UIMenu {
        var menuItems = [UIAction]()
                
        for type in Utilities.userTypes {
            let menuItem = UIAction(title: type,handler: {(_) in
                                self.selectedType = type
                                self.registerView.buttonSelectType.setTitle(self.selectedType, for: .normal)
                            })
            menuItems.append(menuItem)
        }
        
        return UIMenu(title: "Select type", children: menuItems)
    }

}
