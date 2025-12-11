//
//  AllReportsFBManager.swift
//  Wildline
//
//  Created by Student on 12/10/25.
//

import Foundation
import FirebaseFirestore

extension AllReportsViewController {
    func fetchAndFilterReports(documents: [QueryDocumentSnapshot]) async {
        var filteredReports = [Report]()
        
        for document in documents {
            do {
                var report = try document.data(as: Report.self)
                report.id = document.documentID // Manually set the ID
                
                // Check the latest status
                let isCancelled = await checkIfReportCancelled(reportId: document.documentID)
                
                // Only add if not cancelled
                if !isCancelled {
                    filteredReports.append(report)
                }
            } catch {
                print("Error decoding report: \(error)")
            }
        }
        
        self.reports = filteredReports
    }
    
    func checkIfReportCancelled(reportId: String) async -> Bool {
        do {
            let statusSnapshot = try await db.collection("reports")
                .document(reportId)
                .collection("status")
                .order(by: "createdAt", descending: true)
                .limit(to: 1)
                .getDocuments()
            
            if let latestStatusDoc = statusSnapshot.documents.first {
                let latestStatus = try latestStatusDoc.data(as: Status.self)
                
                // Check if the latest status is Cancelled
                return latestStatus.type == .Cancelled
            }
            
            return false
        } catch {
            print("Error checking report status for \(reportId): \(error)")
            return false // If we can't check, show it anyway
        }
    }
}
