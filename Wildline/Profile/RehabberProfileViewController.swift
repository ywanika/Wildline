//
//  RehabberProfileViewController.swift
//  Wildline
//
//  Created by Ciara Hanley on 12/2/25.

import UIKit

class RehabberProfileViewController: ProfileViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var rehabberProfileView: RehabberProfileView {
        return profileView as! RehabberProfileView
    }
    
    var certifications: [String] = ["Certificate 1", "Certificate 2", "Certificate 3"]
    
    override func loadView(){
        profileView = RehabberProfileView()
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        
        rehabberProfileView.certificationsCollectionView.delegate = self
        rehabberProfileView.certificationsCollectionView.dataSource = self
        rehabberProfileView.certificationsCollectionView.register(CertificationCell.self, forCellWithReuseIdentifier: "CertificationCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return certifications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CertificationCell", for: indexPath) as! CertificationCell
        cell.titleLabel.text = certifications[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: certifications[indexPath.item], message: "Certificate details would go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
