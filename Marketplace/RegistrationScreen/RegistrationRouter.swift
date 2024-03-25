//
//  RegistrationRouter.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 07.03.2024.
//

import Foundation
import UIKit

protocol RegistrationRouterProtocol: AnyObject {
    func presentMainScreen()
    func presentLoginScreen()
}

class RegistrationRouter: RegistrationRouterProtocol {
    weak var transitionHandler: UIViewController?
    private let mainTabBarAssembly = MainTabBarAssembly()
    private let loginAssembly = LoginAssembly()
    
    func presentMainScreen() {
        if let transitionHandler = transitionHandler {
            let mainViewController = mainTabBarAssembly.assemble()
            transitionHandler.navigationController?.pushViewController(mainViewController, animated: true)
        }
    }
    
    func presentLoginScreen() {
//        if let transitionHandler = transitionHandler {
//            let loginViewController = loginAssembly.assemble()
//            transitionHandler.navigationController?.pushViewController(loginViewController, animated: true)
//        }
        print("123")
    }
}
