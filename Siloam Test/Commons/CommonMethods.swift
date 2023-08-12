//
//  CommonMethods.swift
//  Siloam Test
//
//  Created by Apple on 11/08/23.
//

import Foundation
import UIKit

struct CommonMethods {
    // MARK: - Show Alert
    
    func showCommonAlert(viewController: UIViewController, message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alertController, animated: true)
    }
}
