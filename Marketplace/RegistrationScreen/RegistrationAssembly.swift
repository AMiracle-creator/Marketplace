//
//  RegistrationAssembly.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 07.03.2024.
//

import Foundation
import UIKit

protocol RegistrationAssemblyProtocol {
    func assemble() -> UIViewController
}

final class RegistrationAssembly: RegistrationAssemblyProtocol {
    func assemble() -> UIViewController {
        let authService = AuthService()
        let alertManager = AlertManager()
        let router = RegistrationRouter()
        let presenter = RegistrationPresenter(authService: authService, alertManager: alertManager, router: router)
        let view = RegistrationController(presenter: presenter)
        presenter.view = view
        router.transitionHandler = view
        return view
    }
}
