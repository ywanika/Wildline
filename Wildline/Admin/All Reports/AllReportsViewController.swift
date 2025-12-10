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
    var listener: ListenerRegistration?
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = allReportsView
    }
    
    @MainActor
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showActivityIndicator()
        
        listener?.remove()
        
        listener = self.db.collection("reports").addSnapshotListener(includeMetadataChanges: false, listener: { querySnapshot, error in
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
                    
                    for document in documents {
                        do {
                            let report = try document.data(as: Report.self)
                            self.reports.append(report)
                        } catch {
                            print("Error decoding report: \(error)")
                        }
                    }
                    
                    self.reports.sort(by: { $0.createdAt > $1.createdAt })
                    
                    print("Loaded \(self.reports.count) reports")
                    for report in self.reports {
                        print(report)
                    }
                    
                    self.allReportsView.reportsTable.reloadData()
                })
        self.hideActivityIndicator()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listener?.remove()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "All Claims"
        
        allReportsView.reportsTable.register(AllReportsTableViewCell.self, forCellReuseIdentifier: AllReportsTableViewCell.identifier)
        allReportsView.reportsTable.delegate = self
        allReportsView.reportsTable.dataSource = self
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
    
    // route to chat with friend
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        tableView.deselectRow(at: indexPath, animated: true)
        //        print(unorderedChatCellArray[indexPath.row].friendUid)
        //
        //        guard let currentUserDocId = UserCache.shared.getUserId() else {
        //            print("Current user id is nil")
        //            return
        //        }
        
        let quickLookViewController = QuickLookViewController()
        navigationController?.pushViewController(quickLookViewController, animated: true)
        quickLookViewController.reportInfo = reports[indexPath.row]
        
        
//        Task {
//            do {
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
