//
//  HomeFBManager.swift
//  Wildline
//
//  Created by Student on 12/10/25.
//
import UIKit
import FirebaseFirestore

extension HomeViewController {
    func fetchReports(from reportRefs: [ReportRef]) async{
        // Clear the array before repopulating
        self.reports.removeAll()
        
        for reportRef in reportRefs {
            do {
                let reportDoc = try await db.collection("reports").document(reportRef.reportId).getDocument()
                
                if reportDoc.exists {
                    let report = try reportDoc.data(as: Report.self)
                    self.reports.append(report)
                } else {
                    print("Report \(reportRef.reportId) does not exist")
                }
            } catch {
                print("Error fetching report \(reportRef.reportId): \(error)")
            }
        }
        
        // Sort by date
        self.reports.sort(by: { $0.createdAt > $1.createdAt })
        
        print("Loaded \(self.reports.count) reports")
        for report in self.reports {
            print(report)
        }
        
        // Reload table on main thread
        await MainActor.run {
            self.homeView.reportsTable.reloadData()
        }
    }
}
