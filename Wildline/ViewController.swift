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

        // USERS BOTTOM BUTTONS
        
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
        
        let tabRehabReports = UINavigationController(rootViewController: ReportsMapViewController())
        let tabRehabReportsItem = UITabBarItem(
            title: "Reports",
            image: UIImage(systemName: "exclamationmark.bubble")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "exclamationmark.bubble.fill")
        )
        tabRehabReports.tabBarItem = tabRehabReportsItem
        tabRehabReports.title = "Reports"
        
        let tabRehabAllClaims = UINavigationController(rootViewController: AllReportsViewController())
        let tabRehabAllClaimsItem = UITabBarItem(
            title: "All Claims",
            image: UIImage(systemName: "long.text.page.and.pencil")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "long.text.page.and.pencil.fill")
        )
        tabRehabAllClaims.tabBarItem = tabRehabAllClaimsItem
        tabRehabAllClaims.title = "All Claims"
        
        
        //MARK: setting up this view controller as the Tab Bar Controller...
        if UserToken.shared.getUserRole() == "admin" {
            self.viewControllers = [tabHome, tabRehabReports, tabRehabAllClaims]
        } else if UserToken.shared.getUserRole() == "user" {
            self.viewControllers = [tabHome, tabReport, tabLearn]
        } else {
            print(UserToken.shared.getUserRole())
        }
        
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
