//
//  QuickLookViewController.swift
//  Wildline
//
//  Created by Anika Sharma on 11/17/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class QuickLookViewController: UIViewController {
    let db = Firestore.firestore()

    var quickLookView = QuickLookView()
    var reportInfo: Report!
    var currentUser:FirebaseAuth.User?
    
    override func loadView(){
        view = quickLookView
        
        quickLookView.titleLabel.text = reportInfo.title
        quickLookView.descriptionLabel.text = reportInfo.description
        quickLookView.reporterNameLabel.text = reportInfo.createdBy
        
        if reportInfo.adminName.isEmpty == true || reportInfo.adminName == "" {
            quickLookView.claimReportButton.isHidden = false
            quickLookView.claimReportButton.addTarget(self, action: #selector(onClaimReportButtonTapped), for: .touchUpInside)
        } else {
            quickLookView.claimReportButton.isHidden = true
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func onClaimReportButtonTapped() {
        claimReport()
        quickLookView.claimReportButton.isHidden = true
    }

}
