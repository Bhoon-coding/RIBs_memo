//
//  LoginTextInputManager.swift
//  RIBs_memo
//
//  Created by BH on 2022/12/13.
//

import Foundation

class LoginTextInputManager {
    class func isValidEmail(_ email: String) -> Bool {
        return email.count >= 5
    }
    
    class func isValidPassword(_ password: String) -> Bool {
        return password.count >= 5
    }
}
