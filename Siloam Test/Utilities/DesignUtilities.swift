//
//  DesignUtilities.swift
//  Siloam Test
//
//  Created by Apple on 12/08/23.
//

import UIKit

let sharedAppDelegate = UIApplication.shared.delegate as! AppDelegate
let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate

var mainWindow: UIWindow? = UIWindow() {
    didSet {
        if #available(iOS 13.0, *) {
            mainWindow = sceneDelegate.window
        }
        else {
            mainWindow = sharedAppDelegate.window
        }
    }
}

var keyWindow: UIWindow {
    guard let window = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first else { return mainWindow! }
    return window
}

class Loader {
    // MARK: - Show/ Hide Loader
    
    func show() {
        keyWindow.isUserInteractionEnabled = false
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        let loaderView = loadingIndicatorView()
        
        let loadingIndicator = activityIndicator(loaderView: loaderView)
        loadingIndicator.startAnimating()
    }
    
    func hide() {
        keyWindow.isUserInteractionEnabled = true
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.white
        
        for vw in keyWindow.subviews {
            if vw.accessibilityIdentifier == AccessibilityIdentifier.loaderView {
                for actInd in vw.subviews {
                    if actInd is UIActivityIndicatorView {
                        if actInd.accessibilityIdentifier == AccessibilityIdentifier.loaderIndicator {
                            actInd.removeFromSuperview()
                        }
                    }
                }
                vw.removeFromSuperview()
            }
        }
    }
    
    // MARK: - Add Loader to Window
    
    private func loadingIndicatorView() -> UIView {
        let loaderView: UIView = UIView()
        loaderView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.size.width, height: keyWindow.frame.size.height)
        loaderView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        loaderView.accessibilityIdentifier = AccessibilityIdentifier.loaderView
       // keyWindow.addSubview(loaderView)

        if #available(iOS 13.0, *) {
            sceneDelegate.window?.addSubview(loaderView)
        }
        else {
            sharedAppDelegate.window?.addSubview(loaderView)
        }
        return loaderView
    }
    
    private func activityIndicator(loaderView:UIView) -> UIActivityIndicatorView {
        let loaderSize:CGFloat = 20
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        let viewWidth:CGFloat = keyWindow.frame.size.width
        let viewHeight:CGFloat = keyWindow.frame.size.height
        loadingIndicator.frame = CGRect(x: viewWidth/2 - loaderSize/2, y: viewHeight/2 - loaderSize/2, width: loaderSize, height: loaderSize)
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.accessibilityIdentifier = AccessibilityIdentifier.loaderIndicator
        loaderView.addSubview(loadingIndicator)
        return loadingIndicator
    }
}
