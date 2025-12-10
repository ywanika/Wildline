//
//  ReportsMapViewController.swift
//  Wildline
//
//  Created by Anika Sharma on 11/17/25.
//

import UIKit

class ReportsMapViewController: UIViewController {

    let reportsMapView = ReportsMapView()
    
    override func loadView() {
        view = reportsMapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reports"

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
