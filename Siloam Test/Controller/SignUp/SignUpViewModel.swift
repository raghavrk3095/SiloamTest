//
//  SignUpViewModel.swift
//  Siloam Test
//
//  Created by Apple on 11/08/23.
//

import Foundation
import UIKit
import Security

class SignUpViewModel {
    
    // MARK: - Variables
    
    var showAlert: ((_ msg: String, _ isSignUp: Bool)->())?
    
    // MARK: - Actions
    
    func checkSignUpButtonFunctionality(username: String, password: String) -> String {
        if username == "" {
            showAlert?(CommonStrings.emptyUname, false)
            return CommonStrings.emptyUname
        }
        else if password == "" {
            showAlert?(CommonStrings.emptyPass, false)
            return CommonStrings.emptyPass
        }
        else {
            // Prepare the query for the keychain
            let query: [CFString: Any] = [
                kSecClass: kSecClassInternetPassword,
                kSecAttrServer: CommonStrings.compName,
                kSecAttrAccount: username.toBase64().data(using: .utf8) ?? "",
                kSecValueData: password.toBase64().data(using: .utf8) ?? ""
            ]
            
            // Delete previous saved data from keychain
            let secItemClasses = [kSecClassGenericPassword,
                kSecClassInternetPassword,
                kSecClassCertificate,
                kSecClassKey,
                kSecClassIdentity]
            for secItemClass in secItemClasses {
                let dictionary = [kSecClass as String:secItemClass]
                SecItemDelete(dictionary as CFDictionary)
            }
            
            // Add the data to the keychain
            let status = SecItemAdd(query as CFDictionary, nil)
            if status == errSecSuccess {
                self.showAlert?(CommonStrings.signUpSuccessful, true)
                return CommonStrings.credsSaved
            } else {
                self.showAlert?(CommonStrings.signUpFailed, false)
                return CommonStrings.failedToSaveCreds
            }
        }
    }
    
    // MARK: - Update password field
    
    func updatePasswordField(textField: UITextField, fieldBtn: UIButton) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        fieldBtn.setImage(UIImage(systemName: textField.isSecureTextEntry ? CommonStrings.eyeSlashImageName : CommonStrings.eyeImageName), for: .normal)
    }
}
