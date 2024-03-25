//
//  AuthCoordinator.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 19.03.2024.
//

import Foundation
import UIKit

protocol AuthCoordinatorOutput: AnyObject {
    func openRegistration()
    func openForgotPassword()
    func openLogin()
    func changeFlow()
}

final class AuthCoordinator: BaseCoordinator {
    
    private var navigationController: UINavigationController
    weak var flowListener: CoordinatorFlowListener?
    
    init(navigationController: UINavigationController, flowListener: CoordinatorFlowListener?) {
        self.flowListener = flowListener
        self.navigationController = navigationController
    }
    
    override func start() {
        let loginController = LoginAssembly().assemble(coordinator: self)
        navigationController.pushViewController(loginController, animated: true)
    }
}

// MARK: - CoordinatorFlowListener

extension AuthCoordinator: CoordinatorFlowListener {
    func onFlowFinished(coordinator: Coordinator) {
        remove(coordinator: self)
        
        flowListener?.onFlowFinished(coordinator: self)
    }
}

// MARK: - AuthCoordinatorOutput

extension AuthCoordinator: AuthCoordinatorOutput {
    
    func openRegistration() {
        let registrationController = RegistrationAssembly().assemble(coordinator: self)
        navigationController.pushViewController(registrationController, animated: true)
    }
    
    func openForgotPassword() {
        let forgotPasswordController = ForgotPasswordAssembly().assemble()
        navigationController.pushViewController(forgotPasswordController, animated: true)
    }
    
    func openLogin() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func changeFlow() {
        onFlowFinished(coordinator: self)
        
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }
}

