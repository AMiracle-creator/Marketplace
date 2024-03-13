//
//  AuthValidator.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 20.01.2024.
//

import Foundation

class AuthValidator {
    
    static func isValidEmail(with email: String) -> Bool {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.{1}[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return  emailPred.evaluate(with: email)
    }
}
