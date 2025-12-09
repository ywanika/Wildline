//
//  MakeReportFBManager.swift
//  Wildline
//
//  Created by Student on 12/8/25.
//

import UIKit
import FirebaseFirestore

extension MakeReportViewController {
    
    
    
    func createReport(report: Report) async throws -> Void {
        guard let currentUserDocId = UserToken.shared.getUserId() else {
            print("Current user id is nil")
            return
        }
        
        let db = Firestore.firestore()
        
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
            print("report added with id: \(result.documentID)")
            
            // clear text fields if successfully added report
            makeReportView.titleField.text = ""
            makeReportView.descriptionTextView.text = ""
            makeReportView.addressField.text = ""
            
        }catch{
            print("Error adding report!")
        }
    }
}
