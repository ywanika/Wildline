//
//  QuickLookViewController.swift
//  Wildline
//
//  Created by Anika Sharma on 11/17/25.
//

import UIKit

class QuickLookViewController: UIViewController {

    var quickLookView = QuickLookView()
    
    override func loadView(){
        view = quickLookView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()    }

}
