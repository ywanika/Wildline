//
//  ViewController.swift
//  Wildline
//
//  Created by Max Grotstein on 11/13/25.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabHome = UINavigationController(rootViewController: HomeViewController())
        let tabHomeBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house")?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(systemName: "house.fill")
        )
        tabHome.tabBarItem = tabHomeBarItem
        tabHome.title = "Home"
        
        //MARK: setting up green tab bar...
        let tabReport = UINavigationController(rootViewController: MakeReportViewController())
        let tabReportBarItem = UITabBarItem(
            title: "Report",
            image: UIImage(systemName: "megaphone")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "megaphone.fill")
        )
        tabReport.tabBarItem = tabReportBarItem
        tabReport.title = "Report"
        
        //MARK: setting up blue tab bar...
        let tabLearn = UINavigationController(rootViewController: LearnViewController())
        let tabLearnBarItem = UITabBarItem(
            title: "Learn",
            image: UIImage(systemName: "book")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "book.fill")
        )
        tabLearn.tabBarItem = tabLearnBarItem
        tabLearn.title = "Learn"
        
        //MARK: setting up this view controller as the Tab Bar Controller...
        self.viewControllers = [tabHome, tabReport, tabLearn]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func presentLoginScreen() {
        let loginVC = LoginViewController() // or however you instantiate it
        loginVC.modalPresentationStyle = .fullScreen // Makes it cover the entire screen
        present(loginVC, animated: false, completion: nil) // animated: false for immediate display
    }
}
