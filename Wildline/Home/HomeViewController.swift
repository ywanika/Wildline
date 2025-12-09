//
//  HomeViewController.swift
//  Wildline
//
//  Created by Max Grotstein on 11/18/25.
//

import UIKit

class HomeViewController: UIViewController {
    let homeView = HomeView()
    var reports = [Report]()
    
    override func loadView() {
        view = homeView
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
        
        homeView.reportsTable.delegate = self
        homeView.reportsTable.dataSource = self
        
        reports.append(Report(title: "lost falcon", userName: "alice", userEmail: "alice@gmail.com", userPhoneNumber: "1112223333", description: "i just found them here!", location: "10 Coventry Street, Boston, MA, 01226", status: "looking", createdAt: "10 December 2026"))
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "title",
                                                 for: indexPath) as! ReportTableViewCell
        let report = reports[indexPath.row]
        cell.titleLabel.text = report.title
        cell.timeLabel.text = report.createdAt // TODO: calculate time since
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
        
        let reportDetailsViewController = ReportDetailsViewController()
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
