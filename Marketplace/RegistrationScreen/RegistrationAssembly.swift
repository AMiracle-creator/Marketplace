//
//  RegistrationAssembly.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 07.03.2024.
//

import Foundation
import UIKit

protocol RegistrationAssemblyProtocol {
    func assemble(coordinator: AuthCoordinatorOutput) -> UIViewController
}

final class RegistrationAssembly: RegistrationAssemblyProtocol {
    func assemble(coordinator: AuthCoordinatorOutput) -> UIViewController {
        let authService = AuthService()
        let alertManager = AlertManager()
        let presenter = RegistrationPresenter(authService: authService, alertManager: alertManager, coordinator: coordinator)
        let view = RegistrationController(presenter: presenter)
        presenter.view = view
        return view
    }
}
