//
//  ForgotPasswordRouter.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 07.03.2024.
//

import Foundation
import UIKit

protocol ForgotPasswordRouterProtocol: AnyObject {
    func presentMainScreen()
}

class ForgotPasswordRouter: ForgotPasswordRouterProtocol {
    weak var transitionHandler: UIViewController?
    private let mainTabBarAssembly = MainTabBarAssembly()
    
    func presentMainScreen() {
        if let transitionHandler = transitionHandler {
            let mainViewController = mainTabBarAssembly.assemble()
            transitionHandler.navigationController?.present(mainViewController, animated: true)
        }
    }
}
