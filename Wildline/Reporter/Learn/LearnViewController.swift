//
//  LearnViewController.swift
//  Wildline
//
//  Created by Max Grotstein on 11/18/25.
//

import UIKit

class LearnViewController: UIViewController {
    let learnView = LearnView()
    
    override func loadView() {
        view = learnView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Learn"

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
