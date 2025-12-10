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
                
                // MARK: Adding report to rehaber
                let reportRef = ReportRef(reportId: reportId)
                
                let userReports = db.collection("users").document(myUserId).collection("reports")
                
                do{
                    let result = try userReports.addDocument(from: reportRef) {error in
                        if let error = error {
                            return
                        }
                        
                    }
                    
                    print("reportRef added with id: \(result.documentID)")
                    
                }catch{
                    print("Error adding report!")
                }
                
                print("Report claimed successfully")
                
            } catch {
                print("Error claiming report: \(error)")
            }
        }
        
    }
}
