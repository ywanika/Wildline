//
//  ReportDetailsViewController.swift
//  Wildline
//
//  Created by Anika Sharma on 11/17/25.
//

import UIKit

class ReportDetailsViewController: UIViewController {

    let reportsDetails = ReportDetailsView()
    var report: Report? = nil
    
    override func loadView() {
        view = reportsDetails
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Reports Details"

        populateView()
        // Do any additional setup after loading the view.
    }
    
    func populateView() {
        guard let report = report else { return }
        reportsDetails.reporterNameLabel.text = report.createdBy
        reportsDetails.reporterPhoneLabel.text = report.userPhoneNumber
        reportsDetails.descriptionTextView.text = report.description
        
    }
}
