//
//  EducationViewController.swift
//  Final Project
//
//  Created by Student on 11/16/25.
//

import UIKit

class EducationViewController: UIViewController {

    var educationView = EducationView()
    
    override func loadView() {
        view = educationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Wildlife Rehabilitation"

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
