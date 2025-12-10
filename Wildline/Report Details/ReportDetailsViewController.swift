//
//  ReportDetailsViewController.swift
//  Wildline
//
//  Created by Anika Sharma on 11/17/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ReportDetailsViewController: UIViewController {

    let reportsDetails = ReportDetailsView()
    var reportInfo: Report!
    var currentUserRole = UserToken.shared.getUserRole()
    var nextActionLabel: UpdateTypes?
    let db = Firestore.firestore()
    var statusListener: ListenerRegistration?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        statusListener?.remove()
        
        guard let reportId = reportInfo.id else {
            print("Report ID is nil")
            return
        }
        
        statusListener = self.db.collection("reports")
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
                    self.nextActionLabel = UpdateTypes.Cancelled
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
                    } else if latestStatus.type == UpdateTypes.Cancelled {
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
    
    override func loadView() {
        view = reportsDetails
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Reports Details"
        
        reportsDetails.titleLabel.text = reportInfo.title
        reportsDetails.reporterNameLabel.text = reportInfo.createdBy
        reportsDetails.reporterPhoneLabel.text = reportInfo.userPhoneNumber
        reportsDetails.descriptionTextView.text = reportInfo.description
        
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
                        reportsDetails.actionButton.isHidden = true
                    default:
                        reportsDetails.configureForRehabber(nextActionTextLabel: "Send Update: \(nextActionLabel?.rawValue ?? "")")
                        reportsDetails.actionButton.addTarget(self, action: #selector(onUpdateButtonTapped), for: .touchUpInside)
                    }
                    
                    //withdraw claim
                    reportsDetails.updateButton.addTarget(self, action: #selector(onWithdrawTapped), for: .touchUpInside)
                }
            }
        } else if currentUserRole == "user" {
            reportsDetails.configureForReporter()
            //TODO give users delete option
        } else {
            showAlert(on: self, title: "No User Found", message: "")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        statusListener?.remove()
    }
    
    @objc func onUpdateButtonTapped(){
        makeUpdate()
    }
    
    @objc func onWithdrawTapped(){
        withdrawReport()
        reportsDetails.configureForViewer()
        navigationController?.popViewController(animated: true)
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
    
}
