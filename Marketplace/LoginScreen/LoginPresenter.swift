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
    let coordinator: AuthCoordinatorOutput?
    var alertManager: AlertManager?
    
    init(authService: AuthServiceProtocol, alertManager: AlertManager, router: LoginRouterProtocol, coordinator: AuthCoordinatorOutput) {
        self.router = router
        self.authService = authService
        self.alertManager = alertManager
        self.coordinator = coordinator
    }
    
    // MARK: - MainViewOutput
    func didTapSignIn(email: String, password: String) {
        authService?.signIn(email: email, password: password, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
//                self.router?.presentMainScreen()
                self.coordinator?.changeFlow()
            case .failure(let error):
                guard let alertManager = alertManager else { return }
                self.view?.updateView(alertManager: alertManager, error: error)
            }
        })
    }
    
    func didTapNewUser() {
        self.coordinator?.openRegistration()
    }
    
    func didTapForgotPassword() {
        self.coordinator?.openForgotPassword()
    }
}
