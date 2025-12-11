//
//  ReportDetailsFBViewController.swift
//  Wildline
//
//  Created by Anika Sharma on 12/10/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


extension ReportDetailsViewController{

    /// Set the next update action by getting the latest status and finding the next status
    func setNextAction() async {
        do {
            guard let reportId = reportInfo.id else {
                print("Report ID is nil")
                return
            }
            
            // MARK: Get most recent status type
            let statusSnapshot = try await db.collection("reports")
                .document(reportId)
                .collection("status")
                .order(by: "createdAt", descending: true)
                .limit(to: 1)
                .getDocuments()
            
            guard let latestStatusDoc = statusSnapshot.documents.first else {
                print("No status found")
                nextActionLabel = UpdateTypes.Cancelled
                return
            }
            
            let latestStatus = try latestStatusDoc.data(as: Status.self)
            print("current status: \(latestStatus.type.rawValue)")
                        
            // MARK: Get next status type
            if let currentIndex = updateOrder.firstIndex(of: latestStatus.type) {
                let nextIndex = currentIndex + 1
                if nextIndex < updateOrder.count {
                    self.nextActionLabel = updateOrder[nextIndex]
                    print("Next action: \(self.nextActionLabel?.rawValue ?? "none")")
                } else {
                    print("Report is already at final status")
                    self.nextActionLabel = nil
                }
            } else if latestStatus.type == UpdateTypes.Cancelled {
                self.nextActionLabel = nil
            } else{
                print("Current status type not found in update order")
                self.nextActionLabel = nil
            }
            
        } catch {
            print("Error fetching status: \(error)")
        }
    }
    
    ///send next status
    func makeUpdate(message: String){
        guard let unwrappedUpdate = nextActionLabel else{
            print ("No update")
            return
        }
        
        guard let myUserId = UserToken.shared.getUserId() else {
            print("User not found")
            return
        }
        
        guard let reportId = reportInfo.id else {
            print("Report ID is nil")
            return
        }
        
        Task{
            do{
                let rehabber = try await Utilities.getUser(for: myUserId)
                let status = Status(type: unwrappedUpdate, message: message, createdAt: Date())
                try db.collection("reports")
                    .document(reportId)
                    .collection("status")
                    .addDocument(from: status)
            }
        }
        
    }
    
    /// Removes rehabber from report, updates status of report, and removes report from rehabber
    func withdrawReport() {
        
        guard let myUserId = UserToken.shared.getUserId() else {
            print("User not found")
            return
        }
        
        Task {
            do {
                let rehabber = try await Utilities.getUser(for: myUserId)
                
                // MARK: Removing rehabber from report
                guard let reportId = reportInfo.id else {
                    print("Report ID is nil")
                    return
                }
                
                // Update Firestore document - remove admin fields
                try await db.collection("reports").document(reportId).updateData([
                    "adminName": "",
                    "adminPhoneNumber": ""
                ])
                
                // Update local object
                reportInfo.adminName = ""
                reportInfo.adminPhoneNumber = ""
                
                // MARK: Adding withdrawal status to report
                let status = Status(
                    type: UpdateTypes.Cancelled,
                    message: "\(rehabber.name) has withdrawn from this report. Finding a new rehabber!",
                    createdAt: Date()
                )
                try await db.collection("reports")
                    .document(reportId)
                    .collection("status")
                    .addDocument(from: status)
                
                // MARK: Removing report from rehabber
                let userReportsRef = db.collection("users").document(myUserId).collection("reports")
                
                // Find and delete the report reference
                let querySnapshot = try await userReportsRef
                    .whereField("reportId", isEqualTo: reportId)
                    .getDocuments()
                
                for document in querySnapshot.documents {
                    try await document.reference.delete()
                    print("Report reference removed with id: \(document.documentID)")
                }
                
                print("Report withdrawal successful")
                
            } catch {
                print("Error withdrawing from report: \(error)")
            }
        }
    }

}
