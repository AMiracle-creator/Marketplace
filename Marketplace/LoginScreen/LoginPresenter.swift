//
//  LoginPresenter.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 05.03.2024.
//

import Foundation
import UIKit

protocol LoginViewInput: AnyObject {
    func updateView(alertManager: AlertManager, error: Error)
}

protocol LoginViewOutput: AnyObject {
    func didTapSignIn(email: String, password: String)
    func didTapNewUser()
    func didTapForgotPassword()
}

class LoginPresenter: LoginViewOutput {
    weak var view: LoginViewInput?
    let authService: AuthServiceProtocol?
    let router: LoginRouterProtocol?
    var alertManager: AlertManager?
    
    init(authService: AuthServiceProtocol, alertManager: AlertManager, router: LoginRouterProtocol) {
        self.router = router
        self.authService = authService
        self.alertManager = alertManager
    }
    
    // MARK: - MainViewOutput
    func didTapSignIn(email: String, password: String) {
        authService?.signIn(email: email, password: password, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                self.router?.presentMainScreen()
            case .failure(let error):
                guard let alertManager = alertManager else { return }
                self.view?.updateView(alertManager: alertManager, error: error)
            }
        })
    }
    
    func didTapNewUser() {
        self.router?.presentRegistrationScreen()
    }
    
    func didTapForgotPassword() {
        self.router?.presentForgotPasswordScreen()
    }
}
