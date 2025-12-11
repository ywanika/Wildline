//
//  ReportDetailsViewController.swift
//  Wildline
//
//  Created by Anika Sharma on 11/17/25.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseFirestore

class ReportDetailsViewController: UIViewController {

    let reportsDetails = ReportDetailsView()
//    var report: Report? = nil
    var reportInfo: Report!
    var currentUserRole = UserToken.shared.getUserRole()
    var nextActionLabel: UpdateTypes?
    let db = Firestore.firestore()
    var latestStatusListener: ListenerRegistration?
    var statusesListener: ListenerRegistration?
    var statuses = [Status]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        latestStatusListener?.remove()
        statusesListener?.remove()
        
        guard let reportId = reportInfo.id else {
            print("Report ID is nil")
            return
        }
        
        if currentUserRole == "admin" {
            latestStatusListener = self.db.collection("reports")
                .document(reportId)
                .collection("status")
                .order(by: "createdAt", descending: true)
                .limit(to: 1)
                .addSnapshotListener(includeMetadataChanges: false, listener: { querySnapshot, error in
                    if let error = error {
                        print("Error fetching status: \(error)")
                        return
                    }
                    
                    guard let latestStatusDoc = querySnapshot?.documents.first else {
                        print("No status found")
                        self.nextActionLabel = UpdateTypes.Withdrawn
                        DispatchQueue.main.async {
                            self.updateUIForNextAction()
                        }
                        return
                    }
                    
                    do {
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
                        } else if latestStatus.type == UpdateTypes.Withdrawn {
                            self.nextActionLabel = nil
                        } else{
                            print("Current status type not found in update order")
                            self.nextActionLabel = nil
                        }
                        
                        DispatchQueue.main.async {
                            self.updateUIForNextAction()
                        }
                        
                    } catch {
                        print("Error decoding status: \(error)")
                    }
                })
        }
        
        // add listener for all statuses
        statusesListener = self.db.collection("reports")
            .document(reportId)
            .collection("status")
            .addSnapshotListener(includeMetadataChanges: false, listener: { querySnapshot, error in
                if let error = error {
                    print("Error fetching statuses: \(error)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }
                
                self.statuses = [] as [Status]
                
                for document in documents {
                    do {
                        let status = try document.data(as: Status.self)
                        self.statuses.append(status)
                    } catch {
                        print("Error decoding status: \(error)")
                    }
                }
                
                DispatchQueue.main.async {
                    self.populateTimeline(statuses: self.statuses)
                    
                    if self.currentUserRole == "user" {
                        let sortedStatuses = self.statuses.sorted { $0.createdAt > $1.createdAt }
                        if let latestStatus = sortedStatuses.first,
                           (latestStatus.type == .Cancelled || latestStatus.type == .Finished) {
                            self.reportsDetails.updateButton.isHidden = true
                        }
                    }
                }
            })
        
        DispatchQueue.main.async {
            if self.currentUserRole == "user" {
                self.reportsDetails.configureForReporter()
            }
        }
    }
                                 
    
    override func loadView() {
        view = reportsDetails
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Reports Details"
        
        reportsDetails.titleLabel.text = reportInfo.title
        reportsDetails.reporterNameLabel.text = reportInfo.createdBy
        reportsDetails.reporterPhoneLabel.text = Utilities.formatPhoneNumber(from: reportInfo.userPhoneNumber)   
        reportsDetails.descriptionTextView.text = reportInfo.description
        
        addPin()
        
        if currentUserRole == "admin" {
            print("is admin")
            Task {
                await setNextAction()
                
                // Ensure UI updates happen on main thread
                await MainActor.run {
                    print("next action picked: \(nextActionLabel?.rawValue ?? "none")")
                    
                    switch (nextActionLabel) {
                    case UpdateTypes.Claimed?: // should never show
                        reportsDetails.configureForRehabber(nextActionTextLabel: "Claim Report")
                    case nil: // hits when no more updates
                        reportsDetails.configureForRehabber(nextActionTextLabel: "")
                        reportsDetails.configureForViewer()
                    default:
                        reportsDetails.configureForRehabber(nextActionTextLabel: "Send Update: \(nextActionLabel?.rawValue ?? "")")
                        reportsDetails.actionButton.addTarget(self, action: #selector(onUpdateButtonTapped), for: .touchUpInside)
                    }
                    
                    //withdraw claim
                    reportsDetails.updateButton.addTarget(self, action: #selector(onWithdrawTapped), for: .touchUpInside)
                }
            }
        } else if currentUserRole == "user" {
            print("is user")
            reportsDetails.configureForReporter()
            Task {
                let isClosed = await checkIfReportClosed()
                await MainActor.run {
                    if isClosed {
                        reportsDetails.updateButton.isHidden = true
                    } else {
                        reportsDetails.updateButton.isHidden = false
                        reportsDetails.updateButton.addTarget(self, action: #selector(onCancelTapped), for: .touchUpInside)
                    }
                }
            }
        } else {
            showAlert(on: self, title: "No User Found", message: "")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        latestStatusListener?.remove()
        statusesListener?.remove()
    }
    
    @objc func onUpdateButtonTapped(){
        makeUpdate()
    }
    
    @objc func onWithdrawTapped(){
        withdrawReport()
        reportsDetails.configureForViewer()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func onCancelTapped(){
        let cancelAlert = UIAlertController(
            title: "Cancel Report?",
            message: "Are you sure you want to cancel this report?",
            preferredStyle: .alert
        )
        
        cancelAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: {(_) in
            Task {
                await self.cancelReport()
            }
        }))
        
        cancelAlert.addAction(UIAlertAction(title: "Do Not Cancel", style: .cancel))
        
        self.present(cancelAlert, animated: true)
    }
    
    func updateUIForNextAction() {
        print("Updating UI with next action: \(nextActionLabel?.rawValue ?? "none")")
        
        switch (nextActionLabel) {
        case UpdateTypes.Claimed?:
            reportsDetails.configureForRehabber(nextActionTextLabel: "Claim Report")
        case nil:
            reportsDetails.configureForRehabber(nextActionTextLabel: "")
            reportsDetails.actionButton.isHidden = true
        default:
            reportsDetails.configureForRehabber(nextActionTextLabel: "Send Update: \(nextActionLabel?.rawValue ?? "")")
            reportsDetails.actionButton.addTarget(self, action: #selector(onUpdateButtonTapped), for: .touchUpInside)
        }
    }
    
    func populateTimeline(statuses: [Status]?) {
        // Clear existing timeline
        print("Populating timeline now")
        reportsDetails.timelineStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // If no statuses, add a default one
        guard let statuses = statuses, !statuses.isEmpty else {
            return
        }
        
        // Sort statuses by date (most recent first)
        let sortedStatuses = statuses.sorted { $0.createdAt > $1.createdAt }
        print("sortedStatuses.count: \(sortedStatuses.count)")
        
        // Add each status to timeline
        for (index, status) in sortedStatuses.enumerated() {
            let isLastItem = (index == sortedStatuses.count - 1)
            let eventView = TimelineEventView(status: status, isLastItem: isLastItem)
            reportsDetails.timelineStackView.addArrangedSubview(eventView)
        }
    }
    
    private func addPin() {
        let coordinate = CLLocationCoordinate2D(
            latitude: reportInfo.location.latitude,
            longitude: reportInfo.location.longitude
        )
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Report Location"
        
        reportsDetails.mapPreview.addAnnotation(annotation)
        
        // Center and zoom the map on the pin
        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
        reportsDetails.mapPreview.setRegion(region, animated: false)
    }
}
