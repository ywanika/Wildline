//
//  HomeViewController.swift
//  Wildline
//
//  Created by Max Grotstein on 11/18/25.
//

import UIKit
import FirebaseFirestore

class HomeViewController: UIViewController {
    let homeView = HomeView()
    var openReports = [Report]()
    var closedReports = [Report]()
    var latestStatusTimes: [String: Date] = [:] // reportId: latest status time
    var displayedReports: [Report] {
        return homeView.segmentedControl.selectedSegmentIndex == 0 ? openReports : closedReports
    }
    let db = Firestore.firestore()
    var reportsListener: ListenerRegistration?
    var statusListeners: [String: ListenerRegistration] = [:] // Track status listener by reportId
    
    override func loadView() {
        view = homeView
    }
    
    @MainActor
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reportsListener?.remove()
        removeAllStatusListeners()
        
        guard let currentUserDocId = UserToken.shared.getUserId() else {
            print("Current user id is nil")
            return
        }
        
        reportsListener = self.db.collection("users").document(currentUserDocId).collection("reports")
            .addSnapshotListener(includeMetadataChanges: false, listener: { querySnapshot, error in
                    if let error = error {
                        print("Error fetching reports: \(error)")
                        return
                    }
                    
                    guard let documents = querySnapshot?.documents else {
                        print("No documents found")
                        return
                    }
                
                    var reportRefs = [] as [ReportRef]
                    
                    for document in documents {
                        do {
                            let reportRef = try document.data(as: ReportRef.self)
                            reportRefs.append(reportRef)
                        } catch {
                            print("Error decoding reportRef: \(error)")
                        }
                    }
                
                    Task {
                        await self.fetchReportsAndListenToStatuses(from: reportRefs)
                    }
                })
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reportsListener?.remove()
        removeAllStatusListeners()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .clear
        title = "Your Reports"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let profileButton = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(onProfileBarButtonTap)
        )
        
        navigationItem.rightBarButtonItem = profileButton
        
        if UserToken.shared.getUserId()?.isEmpty == true {
            showModal()
        }
        
        homeView.reportsTable.register(ReportTableViewCell.self, forCellReuseIdentifier: ReportTableViewCell.identifier)
        homeView.reportsTable.delegate = self
        homeView.reportsTable.dataSource = self
        
        homeView.segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    @objc func segmentChanged() {
        homeView.reportsTable.reloadData()
    }
    
    // Ciara - updated this to load the new Profile screens I made
    @objc func onProfileBarButtonTap() {
        let profileVC: UIViewController
        
//        if UserToken.shared.getUserRole() == "admin" {
//            profileVC = RehabberProfileViewController()
//        } else {
//            profileVC = ReporterProfileViewController()
//        }
        profileVC = ProfileViewController()
        
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func showModal() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        self.present(loginViewController, animated: true)
    }
    
    func removeAllStatusListeners() {
        for (_, listener) in statusListeners {
            listener.remove()
        }
        statusListeners.removeAll()
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedReports.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReportTableViewCell.identifier,
                                                 for: indexPath) as! ReportTableViewCell
        let report = displayedReports[indexPath.row]
        cell.titleLabel.text = report.title
        if let reportId = report.id, let latestStatusTime = latestStatusTimes[reportId] {
            cell.timeLabel.text = "Updated \(Utilities.relativeString(from: latestStatusTime))" 
        } else {
            print("No latest status time for report with id: \(report.id ?? "nil")")
            cell.timeLabel.text = Utilities.relativeString(from: report.createdAt)
        }
        return cell
    }

    // route to report details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let currentUserDocId = UserToken.shared.getUserId() else {
            print("Current user id is nil")
            return
        }
        
        guard indexPath.row < displayedReports.count else {
            print("Invalid report index")
            return
        }
        
        let report = displayedReports[indexPath.row]
        
        let reportDetailsViewController = ReportDetailsViewController()
        reportDetailsViewController.reportInfo = report
        
        navigationController?.pushViewController(reportDetailsViewController, animated: true)
    }
}
