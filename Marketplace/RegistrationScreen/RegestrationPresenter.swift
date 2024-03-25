//
//  RegestrationPresenter.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 07.03.2024.
//

import Foundation
import UIKit

protocol RegistrationViewInput: AnyObject {
    func updateView(alertManager: AlertManager, error: Error)
}

protocol RegistrationViewOutput: AnyObject {
    func didTapSignUp(username: String, email: String, password: String)
    func didTapSignIn()
}

class RegistrationPresenter: RegistrationViewOutput {
    weak var view: RegistrationViewInput?
    let authService: AuthServiceProtocol?
    let alertManager: AlertManager?
    let coordinator: AuthCoordinatorOutput?
    
    init(authService: AuthServiceProtocol, alertManager: AlertManager, coordinator: AuthCoordinatorOutput) {
        self.authService = authService
        self.alertManager = alertManager
        self.coordinator = coordinator
    }
    
    // MARK: - MainViewOutput
    func didTapSignUp(username: String, email: String, password: String) {
        authService?.signUp(username: username, email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            guard let alertManager = alertManager else { return }
            
            switch result {
            case .success(_):
                self.coordinator?.changeFlow()
            case .failure(let error):
                self.view?.updateView(alertManager: alertManager, error: error)
            }
        }
    }
    
    func didTapSignIn() {
        self.coordinator?.openLogin()
    }
}
