//
//  LoginViewModel.swift
//  Siloam Test
//
//  Created by Apple on 11/08/23.
//

import UIKit

class LoginViewModel {
    
    // MARK: - Variables
    
    var showAlert: ((_ msg: String) -> ())?
    var loginSuccessful: (() -> ())?
    
    // MARK: - Actions
    
    func checkLoginButtonFunctionality(username: String, password: String) {
        if username == "" {
            self.showAlert?(CommonStrings.emptyUname)
        }
        else if password == "" {
            self.showAlert?(CommonStrings.emptyPass)
        }
        else {
            let credentials = self.retrieveCredentials()
            if credentials.uname != username || credentials.pass != password {
                self.showAlert?(CommonStrings.wrongCreds)
            }
            else {
                self.loginSuccessful?()
            }
        }
    }
    
    // MARK: - Update password field
    
    func updatePasswordField(textField: UITextField, fieldBtn: UIButton) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        fieldBtn.setImage(UIImage(systemName: textField.isSecureTextEntry ? CommonStrings.eyeSlashImageName : CommonStrings.eyeImageName), for: .normal)
    }
    
    // MARK: - Retrieve keychain data
    
    func retrieveCredentials() -> (uname: String, pass: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrServer: CommonStrings.compName,
            kSecReturnAttributes: true,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess, let existingItem = item as? [String: Any],
           let usernameData = existingItem[kSecAttrAccount as String] as? Data,
           let passwordData = existingItem[kSecValueData as String] as? Data,
           let username = String(data: usernameData, encoding: .utf8),
           let password = String(data: passwordData, encoding: .utf8) {
            let uname = username.fromBase64() ?? ""
            let pass = password.fromBase64() ?? ""
            return(uname, pass)
        }
        else {
            print(CommonStrings.failedToRetrieveCreds)
        }
        return("","")
    }
}
