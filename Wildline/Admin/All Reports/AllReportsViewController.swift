//
//  AllReportsViewController.swift
//  Wildline
//
//  Created by Student on 11/26/25.
//

import UIKit
import FirebaseFirestore

class AllReportsViewController: UIViewController {

    let allReportsView = AllReportsView()
    var reports = [Report]()
    let db = Firestore.firestore()
    var reportsListener: ListenerRegistration?
    var statusListeners: [String: ListenerRegistration] = [:]
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = allReportsView
    }
    
    @MainActor
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showActivityIndicator()
        
        reportsListener?.remove()
        removeAllStatusListeners()
        
        reportsListener = self.db.collection("reports")
            .whereField("adminName", in: [NSNull(), ""])
            .addSnapshotListener(includeMetadataChanges: false, listener: { querySnapshot, error in
                    if let error = error {
                        print("Error fetching reports: \(error)")
                        return
                    }
                    
                    guard let documents = querySnapshot?.documents else {
                        print("No documents found")
                        return
                    }
                    
                    // Clear the array before repopulating
                    self.reports.removeAll()
                    
                    Task {
                        await self.fetchAndFilterReports(documents: documents)
                        
                        await MainActor.run {
                            self.reports.sort(by: { $0.createdAt > $1.createdAt })
                            
                            print("Loaded \(self.reports.count) unclaimed, non-cancelled reports")
                            
                            self.setupStatusListeners(for: self.reports)
                            
                            self.allReportsView.reportsTable.reloadData()
                            self.hideActivityIndicator()
                        }
                    }
                })
//        self.hideActivityIndicator()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reportsListener?.remove()
        removeAllStatusListeners()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Unclaimed Reports"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        allReportsView.reportsTable.register(AllReportsTableViewCell.self, forCellReuseIdentifier: AllReportsTableViewCell.identifier)
        allReportsView.reportsTable.delegate = self
        allReportsView.reportsTable.dataSource = self
    }
    
    func setupStatusListeners(for reports: [Report]) {
        // Remove old listeners
        removeAllStatusListeners()
        
        for report in reports {
            guard let reportId = report.id else { continue }
            
            // Listen to status changes for this report
            let reportListener = db.collection("reports")
                .document(reportId)
                .addSnapshotListener { [weak self] documentSnapshot, error in
                    guard let self = self else { return }
                    
                    if let error = error {
                        print("Error listening to report \(reportId): \(error)")
                        return
                    }
                    
                    guard let document = documentSnapshot, document.exists else {
                        return
                    }
                    
                    // When report changes, check if report should be removed
                    Task {
                        let adminName = document.data()?["adminName"] as? String
                        let isClaimed = adminName != nil && !adminName!.isEmpty
                        
//                        let isCancelled = await self.checkIfReportCancelled(reportId: reportId)
                        
                        await MainActor.run {
                            if isClaimed {
                                // Remove the report from the list
                                self.reports.removeAll { $0.id == reportId }
                                self.allReportsView.reportsTable.reloadData()
                                
                                // Remove the listener for this report
                                self.statusListeners["report_\(reportId)"]?.remove()
                                self.statusListeners.removeValue(forKey: "report_\(reportId)")
                                self.statusListeners["status_\(reportId)"]?.remove()
                                self.statusListeners.removeValue(forKey: "status_\(reportId)")
                                
                                let reason = isClaimed ? "claimed" : "cancelled"
                                print("Removed \(reason) report \(reportId)")
                            }
                        }
                    }
                }
            
            let statusListener = db.collection("reports")
                .document(reportId)
                .collection("status")
                .addSnapshotListener { [weak self] querySnapshot, error in
                    guard let self = self else { return }
                    
                    if let error = error {
                        print("Error listening to status for report \(reportId): \(error)")
                        return
                    }
                    
                    Task {
                        let isCancelled = await self.checkIfReportCancelled(reportId: reportId)
                        
                        if isCancelled {
                            await MainActor.run {
                                self.reports.removeAll { $0.id == reportId }
                                self.allReportsView.reportsTable.reloadData()
                                
                                // Remove both listeners
                                self.statusListeners["report_\(reportId)"]?.remove()
                                self.statusListeners.removeValue(forKey: "report_\(reportId)")
                                self.statusListeners["status_\(reportId)"]?.remove()
                                self.statusListeners.removeValue(forKey: "status_\(reportId)")
                                
                                print("Removed cancelled report \(reportId)")
                            }
                        }
                    }
                }
            
            // Store both listeners with unique keys
            statusListeners["report_\(reportId)"] = reportListener
            statusListeners["status_\(reportId)"] = statusListener
        }
    }
    
    func removeAllStatusListeners() {
        for (_, listener) in statusListeners {
            listener.remove()
        }
        statusListeners.removeAll()
    }

}

extension AllReportsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllReportsTableViewCell.identifier, for: indexPath) as! AllReportsTableViewCell
        let report = reports[indexPath.row]
        cell.titleLabel.text = report.title
        cell.distanceLabel.text = "0.5 miles" // TODO: calculate distance based on location
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let quickLookViewController = QuickLookViewController()
        navigationController?.pushViewController(quickLookViewController, animated: true)
        quickLookViewController.reportInfo = reports[indexPath.row]
    }
}

extension AllReportsViewController:ProgressSpinnerDelegate{
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
