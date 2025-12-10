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
    var reports = [Report]()
    let db = Firestore.firestore()
    var listener: ListenerRegistration?
    
    override func loadView() {
        view = homeView
    }
    
    @MainActor
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        listener?.remove()
        
        guard let currentUserDocId = UserToken.shared.getUserId() else {
            print("Current user id is nil")
            return
        }
        
        listener = self.db.collection("users").document(currentUserDocId).collection("reports")
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
                        await self.fetchReports(from: reportRefs)
                    }
                })
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listener?.remove()
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
        
//        reports.append(Report(title: "lost falcon", createdBy: "alice", userEmail: "alice@gmail.com", userPhoneNumber: "1112223333", description: "i just found them here!", location: GeoPoint(latitude: 42.33681, longitude: 71.08579), createdAt: Date()))
//        homeView.reportsTable.reloadData()
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

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReportTableViewCell.identifier,
                                                 for: indexPath) as! ReportTableViewCell
        let report = reports[indexPath.row]
        cell.titleLabel.text = report.title
        cell.timeLabel.text = Utilities.relativeString(from: report.createdAt)
        return cell
    }

    // route to report details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        tableView.deselectRow(at: indexPath, animated: true)
        //        print(unorderedChatCellArray[indexPath.row].friendUid)
        //
        guard let currentUserDocId = UserToken.shared.getUserId() else {
            print("Current user id is nil")
            return
        }
        
        var reportDetailsViewController = ReportDetailsViewController()
        
        reportDetailsViewController.report = reports[indexPath.row]
        
        navigationController?.pushViewController(reportDetailsViewController, animated: true)
        
        
        //        Task {
        //            do {
        //                let chatViewController = ChatViewController()
        //                let friendID = try await self.getFriendDocId(for: unorderedChatCellArray[indexPath.row].chatRefId, currentUser: currentUserDocId)
        //                chatViewController.friend = try await self.getFriend(for: friendID)
        //                chatViewController.friendDocID = friendID
        //
        //                let currentUser = try await getFriend(for: currentUserDocId)
        //                chatViewController.currentUser = currentUser
        //
        //                chatViewController.chatRef = ChatRef(chatId: unorderedChatCellArray[indexPath.row].chatRefId)
        //
        //                print("friend: \(chatViewController.friend!)")
        //                print("friendDocID: \(chatViewController.friendDocID!)")
        //                print("chatRef: \(chatViewController.chatRef!)")
        //                navigationController?.pushViewController(chatViewController, animated: true)
        //            } catch {
        //                print("Can't get friend")
        //            }
        //        }
    }
}
