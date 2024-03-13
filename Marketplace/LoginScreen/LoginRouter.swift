//
//  LoginRouter.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 05.03.2024.
//

import Foundation
import UIKit

protocol LoginRouterProtocol: AnyObject {
    func presentMainScreen()
    func presentForgotPasswordScreen()
    func presentRegistrationScreen()
}

class LoginRouter: LoginRouterProtocol {
    weak var window: UIWindow?
    weak var transitionHandler: UIViewController?
    private let mainTabBarAssembly: MainTabBarAssemblyProtocol = MainTabBarAssembly()
    private let forgotPasswordAssembly: ForgotPasswordAssemblyProtocol = ForgotPasswordAssembly()
    private let registrationAssembly: RegistrationAssemblyProtocol = RegistrationAssembly()
    
    func presentMainScreen() {
        if let transitionHandler = transitionHandler {
            let mainViewController = mainTabBarAssembly.assemble()
            transitionHandler.navigationController?.pushViewController(mainViewController, animated: true)
        }
    }
    
    func presentForgotPasswordScreen() {
        if let transitionHandler = transitionHandler {
            let forgotPasswordController = forgotPasswordAssembly.assemble()
            transitionHandler.navigationController?.pushViewController(forgotPasswordController, animated: true)
        }
    }
    
    func presentRegistrationScreen() {
        if let transitionHandler = transitionHandler {
            let registrationController = registrationAssembly.assemble()
            transitionHandler.navigationController?.pushViewController(registrationController, animated: true)
        }
    }
}
