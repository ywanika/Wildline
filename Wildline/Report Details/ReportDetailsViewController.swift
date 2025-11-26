//
//  ReportDetailsViewController.swift
//  Wildline
//
//  Created by Anika Sharma on 11/17/25.
//

import UIKit

class ReportDetailsViewController: UIViewController {

    let reportsDetails = ReportDetailsView()
    
    override func loadView() {
        view = reportsDetails
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Reports Details"

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
