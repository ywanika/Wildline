//
//  HomeFBManager.swift
//  Wildline
//
//  Created by Student on 12/10/25.
//
import UIKit
import FirebaseFirestore

extension HomeViewController {
    func fetchReportsAndListenToStatuses(from reportRefs: [ReportRef]) async{
        var allReports = [Report]()
        
        for reportRef in reportRefs {
            do {
                let reportDoc = try await db.collection("reports").document(reportRef.reportId).getDocument()
                
                if reportDoc.exists {
                    var report = try reportDoc.data(as: Report.self)
                    report.id = reportRef.reportId
                    allReports.append(report)
                } else {
                    print("Report \(reportRef.reportId) does not exist")
                }
            } catch {
                print("Error fetching report \(reportRef.reportId): \(error)")
            }
        }
        
        await categorizeReports(allReports)
        
        // Reload table on main thread
        await MainActor.run {
            self.setupStatusListeners(for: allReports)
            self.homeView.reportsTable.reloadData()
        }
    }
    
    func categorizeReports(_ reports: [Report]) async {
        var open = [(report: Report, latestStatusTime: Date)]()
        var closed = [(report: Report, latestStatusTime: Date)]()
        var statusTimes: [String: Date] = [:]
        
        for report in reports {
            guard let reportId = report.id else { continue }
            
            // Fetch the latest status for this report
            do {
                let statusSnapshot = try await db.collection("reports")
                    .document(reportId)
                    .collection("status")
                    .order(by: "createdAt", descending: true)
                    .limit(to: 1)
                    .getDocuments()
                
                if let latestStatusDoc = statusSnapshot.documents.first {
                    let latestStatus = try latestStatusDoc.data(as: Status.self)
                    let latestStatusTime = latestStatus.createdAt
                    
                    statusTimes[reportId] = latestStatusTime
                    
                    // Check if report is closed (Finished or Cancelled)
                    if latestStatus.type == .Finished || latestStatus.type == .Cancelled {
                        closed.append((report: report, latestStatusTime: latestStatusTime))
                    } else {
                        open.append((report: report, latestStatusTime: latestStatusTime))
                    }
                } else {
                    // No status found, consider it open
                    // and use report creation time
                    statusTimes[reportId] = report.createdAt
                    open.append((report: report, latestStatusTime: report.createdAt))
                }
            } catch {
                print("Error fetching status for report \(reportId): \(error)")
                statusTimes[reportId] = report.createdAt
                open.append((report: report, latestStatusTime: report.createdAt))
            }
        }
        
        self.latestStatusTimes = statusTimes
        
        // Sort both arrays by date (most recent first)
        self.openReports = open.sorted { $0.latestStatusTime > $1.latestStatusTime }.map {$0.report}
        self.closedReports = closed.sorted { $0.latestStatusTime > $1.latestStatusTime }.map {$0.report}
    }
    
    func setupStatusListeners(for reports: [Report]) {
        // Remove old listeners
        removeAllStatusListeners()
        
        for report in reports {
            guard let reportId = report.id else { continue }
            
            // Listen to status changes for this report
            let listener = db.collection("reports")
                .document(reportId)
                .collection("status")
                .addSnapshotListener { [weak self] querySnapshot, error in
                    guard let self = self else { return }
                    
                    if let error = error {
                        print("Error listening to status for report \(reportId): \(error)")
                        return
                    }
                    
                    // When status changes, recategorize this specific report
                    Task {
                        let allReports = self.openReports + self.closedReports
                        await self.categorizeReports(allReports)
                        
                        await MainActor.run {
                            self.homeView.reportsTable.reloadData()
                        }
                    }
                }
            
            statusListeners[reportId] = listener
        }
    }
}
