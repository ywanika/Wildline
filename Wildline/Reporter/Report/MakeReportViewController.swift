//
//  MakeReportViewController.swift
//  Wildline
//
//  Created by Anika Sharma on 11/15/25.
//

import UIKit
import PhotosUI
import FirebaseFirestore

class MakeReportViewController: UIViewController {
    var makeReportView = MakeReportView()
    var pickedImage:UIImage?
    var currentUser: User!
    
    override func loadView(){
        view = makeReportView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Make a Report"
        makeReportView.buttonSelectPhoto.menu = getMenuImagePicker()
        
        makeReportView.sendReportButton.addTarget(self, action: #selector(onSendTapped), for: .touchUpInside)
    }
    
    func getMenuImagePicker() -> UIMenu{
        let menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    //MARK: take Photo using Camera...
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    //MARK: pick Photo using Gallery...
    func pickPhotoFromGallery(){
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    @objc func onSendTapped() {
        guard let currentUserDocId = UserToken.shared.getUserId() else {
            print("Current user id is nil")
            return
        }
        
        Task {
            do {
                let currentUser = try await getUser(for:currentUserDocId)
                let createdBy = currentUser.name
                let userEmail = currentUser.email
                let userPhoneNumber = currentUser.phoneNumber
                let title = makeReportView.titleField.text
                let description = makeReportView.descriptionTextView.text
                let location = makeReportView.addressField.text
                let createdAt = Date()
                
                if (!isValidReport(createdBy: createdBy, userEmail: userEmail, userPhoneNumber: userPhoneNumber, title: title ?? "", description: description ?? "", location: location ?? "", createdAt: createdAt)) {
                                    showAlert(on: self, title: "Alert!", message: "Make sure you fill in all the required fields.")
                                    return
                                }
            
                guard let coords = Utilities.parseLocation(location: location ?? "") else {
                                   showAlert(on: self, title: "Alert!", message: "Location must be formatted as 'latitude/longitude'.")
                                   return
                               }

                               let report = Report(title: title!, createdBy: createdBy, userEmail: userEmail, userPhoneNumber: userPhoneNumber,description: description, location: coords, createdAt: createdAt)
                
                try await self.createReport(report: report)
            }
        }
    }
    
    func getUser(for uid: String) async throws -> User {
        
        
        let db = Firestore.firestore()
        
        let document = db.collection("users").document(uid)
        let snapshot = try await document.getDocument()
        
        let user = try snapshot.data(as: User.self)
        
        return user
    }

}

//MARK: adopting required protocols for UIImagePicker...
extension MakeReportViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.makeReportView.buttonSelectPhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            // Do your thing for No image loaded...
        }
    }
}

//MARK: adopting required protocols for PHPicker...
extension MakeReportViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.makeReportView.buttonSelectPhoto.setImage(
                                uwImage.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            self.pickedImage = uwImage
                        }
                    }
                })
            }
        }
    }
}

