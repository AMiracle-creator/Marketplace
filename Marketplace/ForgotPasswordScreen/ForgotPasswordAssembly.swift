//
//  ForgotPasswordAssembly.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 07.03.2024.
//

import Foundation
import UIKit

protocol ForgotPasswordAssemblyProtocol {
    func assemble() -> UIViewController
}

final class ForgotPasswordAssembly: ForgotPasswordAssemblyProtocol {
    func assemble() -> UIViewController {
        let authService = AuthService()
        let alertManager = AlertManager()
        let router = ForgotPasswordRouter()
        let presenter = ForgotPasswordPresenter(authService: authService, alertManager: alertManager, router: router)
        let view = ForgotPasswordController(presenter: presenter)
        presenter.view = view
        router.transitionHandler = view
        return view
    }
}
