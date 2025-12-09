//
//  LoginFBManager.swift
//  Wildline
//
//  Created by Max Grotstein on 12/8/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

extension LoginViewController {
    
    func signInToFirebase(email: String, password: String){
        //MARK: can you display progress indicator here?
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
        //MARK: authenticating the user...
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil{
                //MARK: can you hide the progress indicator here?
                self.childProgressView.willMove(toParent: nil)
                self.childProgressView.view.removeFromSuperview()
                self.childProgressView.removeFromParent()
                
                Task {
                    do {
                        try await self.setupUserDefaultsUserId(email: email)
                        self.goToMain()
                    }
                }
                
            }else{
                //MARK: can you hide the progress indicator here?
                self.childProgressView.willMove(toParent: nil)
                self.childProgressView.view.removeFromSuperview()
                self.childProgressView.removeFromParent()
                //MARK: alert that no user found or password wrong...
                self.showError(message: "Incorrect Email-Password Combination!")
            }
        })
    }
    
    func setupUserDefaultsUserId(email: String) async throws -> Void {
        let db = Firestore.firestore()
        
        let documents = db.collection("users").whereField("email", isEqualTo: email)
        let snapshot = try await documents.getDocuments()
        
        guard let document = snapshot.documents.first else {
           print("User not found")
           return
        }
        
        UserToken.shared.saveUserId(document.documentID)
        UserToken.shared.saveUserRole(document.data()["role"] as! String)
    }
}
