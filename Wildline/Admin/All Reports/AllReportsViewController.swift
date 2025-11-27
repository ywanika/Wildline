//
//  AllReportsViewController.swift
//  Wildline
//
//  Created by Student on 11/26/25.
//

import UIKit

class AllReportsViewController: UIViewController {

    let allReportsView = AllReportsView()
    var reports: [String] = []
    
    override func loadView() {
        view = allReportsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "All Claims"

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AllReportsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "names",
                                                 for: indexPath) as! AllReportsTableViewCell
        let report = reports[indexPath.row]
        cell.titleLabel.text = report.title
        cell.distanceLabel.text = report.distance
        cell.statusLabel.text = report.status
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
        
        let reportDetailsController = ReportDetailsViewController()
        navigationController?.pushViewController(reportDetailsController, animated: true)
        
        
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
