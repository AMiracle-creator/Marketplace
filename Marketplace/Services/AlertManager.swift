//
//  AlertManager.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 18.01.2024.
//

import Foundation
import UIKit


class AlertManager {
    private func showBasicAlert(on viewController: UIViewController, title: String,  message: String?) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Принять", style: .default))
            viewController.present(alert, animated: true)
    }
}


// MARK: - Show Validation Alerts

extension AlertManager {
    public func showInvalidEmailAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "Некорртектная почта", message: "Пожалуйста введите корректную почту")
    }
    
    public func showInvalidPasswordAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "Некорртектный пароль", message: "Пожалуйста введите корректный пароль")
    }
    
    public func showInvalidUsernameAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "Некорртектное имя пользователя", message: "Пожалуйста введите корректное имя пользователя")
    }
}

// MARK: - Registration Errors

extension AlertManager {
    public func showRegistrationErrorAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "Неизвестная ошибка при регистрации", message: nil)
    }
    
    public func showRegistrationErrorAlert(on viewController: UIViewController, with error: Error) {
        self.showBasicAlert(on: viewController, title: "Ошибка при регистрации", message: "\(error.localizedDescription)")
    }
}

// MARK: - Log In Errors

extension AlertManager {
    public func showSignInErrorAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "Неизвестная ошибка при авторизации", message: nil)
    }
    
    public func showSignInErrorAlert(on viewController: UIViewController, with error: Error) {
        self.showBasicAlert(on: viewController, title: "Ошибка при авторизации", message: "\(error.localizedDescription)")
    }
}

// MARK: - Logout Errors

extension AlertManager {
    public func showLogoutErrorAlert(on viewController: UIViewController, with error: Error) {
        self.showBasicAlert(on: viewController, title: "Ошибка при попытке выхода из аккаунта", message: "\(error.localizedDescription)")
    }
}

// MARK: - Forgot Password Errors

extension AlertManager {
    public func showPasswordResetSentAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "На вашу почту выслано письмо для смены пароля", message: nil)
    }
    
    public func showErrorSendingPasswordResetAlert(on viewController: UIViewController, with error: Error) {
        self.showBasicAlert(on: viewController, title: "Ошибка при попытке смены пароля", message: "\(error.localizedDescription)")
    }
}

// MARK: - Fetching User Errors

extension AlertManager {
    public func showUnknownFetchingUserErrorAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "Unknown error fetchin user", message: nil)
    }
    
    public func showFetchingUserErrorAlert(on viewController: UIViewController, with error: Error) {
        self.showBasicAlert(on: viewController, title: "Fetching user error", message: "\(error.localizedDescription)")
    }
}
