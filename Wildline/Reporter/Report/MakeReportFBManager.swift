//
//  MakeReportFBManager.swift
//  Wildline
//
//  Created by Student on 12/8/25.
//

import UIKit
import FirebaseFirestore

extension MakeReportViewController {
    func createReport(report: Report, userId: String) async throws -> Void {
        let collectionReports = db.collection("reports")
        
        do{
            let result = try collectionReports.addDocument(from: report) {error in
                if let error = error {
                    //MARK: hide progress indicator...
//                    self.hideActivityIndicator()
                    
//                    self.navigationController?.popViewController(animated: true)
                    return
                }
                
            }
            
            var status = Status(type: UpdateTypes.Created, message: "Report Created", createdAt: Date())
            try db.collection("reports")
                .document(result.documentID)
                .collection("status")
                .addDocument(from: status)
            
            // if successful, then add to user's collection of reportIds
            addReportToUser(reportId: result.documentID, userId: userId)
            
            print("report added with id: \(result.documentID)")
            
            let newReport = try await Utilities.getReport(for: result.documentID)
            redirectToReportDetails(report: newReport)

        }catch{
            print("Error adding report!")
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
            
            // clear text fields if successfully added report
            makeReportView.titleField.text = ""
            makeReportView.descriptionTextView.text = ""
            makeReportView.addressField.text = ""
            
        }catch{
            print("Error adding report!")
        }
    }
    
    func redirectToReportDetails(report: Report) {
        let vc = ReportDetailsViewController()
        
        vc.reportInfo = report
        navigationController?.pushViewController(vc, animated: true)
    }
}
