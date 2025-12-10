//
//  MakeReportViewController.swift
//  Wildline
//
//  Created by Anika Sharma on 11/15/25.
//

import UIKit
import PhotosUI
import FirebaseFirestore

class MakeReportViewController: UIViewController {
    var makeReportView = MakeReportView()
    var pickedImage:UIImage?
    var currentUser: User!
    let db = Firestore.firestore()
    
    override func loadView(){
        view = makeReportView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Make a Report"
        makeReportView.sendReportButton.addTarget(self, action: #selector(onSendTapped), for: .touchUpInside)
    }
    
    @objc func onSendTapped() {
        guard let currentUserDocId = UserToken.shared.getUserId() else {
            print("Current user id is nil")
            return
        }
        
        Task {
            do {
//                guard let currentUser = try await getUser(for:currentUserDocId) else {
//                    showAlert(on: self, title: "Error", message: "Could not fetch user data.")
//                }
                let currentUser = try await Utilities.getUser(for:currentUserDocId)
                let createdBy = currentUser.name
                let userEmail = currentUser.email
                let userPhoneNumber = currentUser.phoneNumber
                let title = makeReportView.titleField.text
                let description = makeReportView.descriptionTextView.text
                let location = makeReportView.addressField.text
                let createdAt = Date()
                
                if (!isValidReport(createdBy: createdBy, userEmail: userEmail, userPhoneNumber: userPhoneNumber, title: title ?? "", description: description ?? "", location: location ?? "", createdAt: createdAt)) {
                                    showAlert(on: self, title: "Alert!", message: "Make sure you fill in all the required fields.")
                                    return
                                }
            
                guard let coords = Utilities.parseLocation(location: location ?? "") else {
                                   showAlert(on: self, title: "Alert!", message: "Location must be formatted as 'latitude/longitude'.")
                                   return
                               }

                               let report = Report(title: title!, createdBy: createdBy, userEmail: userEmail, userPhoneNumber: userPhoneNumber,description: description, location: coords, createdAt: createdAt)
                
                try await self.createReport(report: report, userId: currentUserDocId)
            }
        }
    }

}
