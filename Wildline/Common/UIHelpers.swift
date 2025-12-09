//
//  UIHelpers.swift
//  WA7_Hanley_4706
//
//  Created by Ciara Hanley on 10/23/25.
//

import UIKit

func showAlert(on vc: UIViewController, message: String) {
    let ac = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    vc.present(ac, animated: true)
}
