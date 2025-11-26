//
//  AllReportsViewController.swift
//  Wildline
//
//  Created by Student on 11/26/25.
//

import UIKit

class AllReportsViewController: UIViewController {

    let allReportsView = AllReportsView()
    var reports = [Report]()
    
    override func loadView() {
        view = allReportsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "All Claims"
        
        reports.append(Report(title: "lost falcon", userName: "alice", userEmail: "alice@gmail.com", userPhoneNumber: "1112223333", description: "i just found them here!", location: "10 Coventry Street, Boston, MA, 01226", status: "looking"))

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
