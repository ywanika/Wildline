//
//  RegisterFBManager.swift
//  Wildline
//
//  Created by Max Grotstein on 12/7/25.
//

import Foundation
import FirebaseAuth
import UIKit
import FirebaseFirestore

extension RegisterViewController{
    
    func registerNewAccount(user: User){
        //MARK: display the progress indicator...
        showActivityIndicator()
        //MARK: create a Firebase user with email and password...
        if !user.name.isEmpty,
           let email = registerView.emailField.text,
           let password = registerView.passwordField.text{
            //TODO Validations....
            if (firstName == "" || lastName == "") {
                showAlert(on: self, title: "Error!", message: "Need to have first and last name")
            }
            var name = firstName + " " + lastName
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    //MARK: the user creation is successful...
                    self.setNameOfTheUserInFirebaseAuth(name: user.name)
                    self.saveContactToFireStore(user: user)
                    
                }else{
                    //MARK: there is a error creating the user...
                    print(error)
                    self.hideActivityIndicator()
                }
            })
        }
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                
//                //MARK: the profile update is successful...
//                self.loginSuccessful(userId: <#T##String#>, userRole: <#T##String#>)
                
                //MARK: hide the progress indicator...
                self.hideActivityIndicator()
                
                //MARK: pop the current controller...
                //self.navigationController?.popViewController(animated: true)
            }else{
                //MARK: there was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    func saveContactToFireStore(user: User) {
        let collectionUsers = database
            .collection("users")
        
        //MARK: show progress indicator...
        showActivityIndicator()
        
        do{
            try collectionUsers.addDocument(from: user, completion: {(error) in
                if error == nil{
                    Task {
                        do {
                            try await self.setupUserDefaultsUserId(email: user.email)
                            self.loginSuccessful(userId: UserToken.shared.getUserId()!, userRole: user.role)
                            //MARK: hide progress indicator...
                            self.hideActivityIndicator()
                        }
                    }
                }
            })
        }catch{
            print("Error adding document!")
        }
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
    }
}
