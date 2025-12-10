//
//  AllReportsFBViewController.swift
//  Wildline
//
//  Created by Anika Sharma on 12/9/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

extension QuickLookViewController {

    ///Adds rehaber to report, updates status of report, and adds report to rehabber
    func claimReport() {
        
        
        guard let myUserId = UserToken.shared.getUserId() else {
            print("User not found")
            return
        }
        
        Task {
            do {
                let rehabber = try await Utilities.getUser(for: myUserId)
                
                // MARK: Adding rehabber to report
                // Update local object
                reportInfo.adminName = rehabber.name
                reportInfo.adminPhoneNumber = rehabber.phoneNumber
                
                // Update Firestore document
                guard let reportId = reportInfo.id else {
                    print("Report ID is nil")
                    return
                }
                
                try await db.collection("reports").document(reportId).updateData([
                    "adminName": rehabber.name,
                    "adminPhoneNumber": rehabber.phoneNumber
                ])
                
                // MARK: Adding status to report
                var status = Status(type: UpdateTypes.Clamied, message: "\(rehabber.name) has claimed this report!", createdAt: Date())
                try db.collection("reports")
                    .document(reportId)
                    .collection("status")
                    .addDocument(from: status)
                
                // MARK: Adding rehabber to report
                
                print("Report claimed successfully")
                addReportToUser(reportId: reportId, userId: myUserId)
                
            } catch {
                print("Error claiming report: \(error)")
            }
        }
        
    }
    
    func addReportToUser(reportId: String, userId: String) {
        guard !reportId.isEmpty, !userId.isEmpty else {
            print("Error: reportId or userId is empty")
            print("reportId: '\(reportId)', userId: '\(userId)'")
            return
        }
        
        let reportRef = ReportRef(reportId: reportId)
        
        let userReports = db.collection("users").document(userId).collection("reports")
        
        do{
            let result = try userReports.addDocument(from: reportRef) {error in
                if let error = error {
                    //MARK: hide progress indicator...
//                    self.hideActivityIndicator()
                    
//                    self.navigationController?.popViewController(animated: true)
                    return
                }
                
            }
            
            print("reportRef added with id: \(result.documentID)")
            
        }catch{
            print("Error adding report!")
        }
    }
}
