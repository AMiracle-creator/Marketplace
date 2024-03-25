//
//  LoginAssembly.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 05.03.2024.
//

import Foundation
import UIKit

protocol LoginAssemblyProtocol {
    func assemble(coordinator: AuthCoordinatorOutput) -> UIViewController
}

final class LoginAssembly: LoginAssemblyProtocol {
    func assemble(coordinator: AuthCoordinatorOutput) -> UIViewController {
        let authService = AuthService()
        let alertManager = AlertManager()
        let presenter = LoginPresenter(authService: authService, alertManager: alertManager, coordinator: coordinator)
        let view = LoginController(presenter: presenter)
        presenter.view = view
        return view
    }
}
