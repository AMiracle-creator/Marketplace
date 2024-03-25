//
//  ForgotPasswordPresenter.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 07.03.2024.
//

import Foundation
import UIKit

protocol ForgotPasswordInput: AnyObject {
    func updateView(alertManager: AlertManager, error: Error?)
}

protocol ForgotPasswordViewOutput: AnyObject {
    func didTapResetPassword(email: String)
}

class ForgotPasswordPresenter: ForgotPasswordViewOutput {
    weak var view: ForgotPasswordInput?
    let authService: AuthServiceProtocol?
    let alertManager: AlertManager
    
    init(authService: AuthServiceProtocol, alertManager: AlertManager) {
        self.authService = authService
        self.alertManager = alertManager
    }
    
    // MARK: - MainViewOutput
    func didTapResetPassword(email: String) {
        authService?.forgotPassword(email: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.view?.updateView(alertManager: alertManager, error: error)
                return
            }
            
            self.view?.updateView(alertManager: alertManager, error: nil)
        }
    }
}
