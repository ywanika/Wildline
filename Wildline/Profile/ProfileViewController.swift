//
//  ProfileViewController.swift
//  WA8_4
//
//  Created by Max Grotstein on 11/6/25.
//

import UIKit
//import FirebaseAuth

class ProfileViewController: UIViewController {

    var profileView = ProfileView()
//    var handleAuth: AuthStateDidChangeListenerHandle?
//    var currentUser:FirebaseAuth.User?
    
    override func loadView(){
        view = profileView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
//            if user == nil{
//                //MARK: not signed in...
//            }else{
//                //MARK: the user is signed in...
//                self.currentUser = user
//                self.profileView.nameLabel.text = user?.displayName
//                self.profileView.emailLabel.text = user?.email
//            }
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemBackground
        
        profileView.logoutButton.addTarget(self, action: #selector(onLogOutButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }

    @objc func onLogOutButtonTapped(){
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?",
            preferredStyle: .actionSheet)
//        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
//                do{
////                    try Auth.auth().signOut()
////                    UserCache.shared.clearUserId()
//                    self.navigationController?.popViewController(animated: true)
//                    self.navigationController?.popViewController(animated: true)
//                }catch{
//                    print("Error occured!")
//                }
//            })
//        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }


}
