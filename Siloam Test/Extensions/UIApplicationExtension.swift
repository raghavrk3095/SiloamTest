//
//  UIApplicationExtension.swift
//  Siloam Test
//
//  Created by Apple on 12/08/23.
//

import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        if #available(iOS 13.0, *) {//Above ios 13, required status bar appearance is shown by default.
        } else {
            // Fallback on earlier versions
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        
        return nil
    }
}
