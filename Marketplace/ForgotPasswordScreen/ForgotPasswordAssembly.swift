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
        let presenter = ForgotPasswordPresenter(authService: authService, alertManager: alertManager)
        let view = ForgotPasswordController(presenter: presenter)
        presenter.view = view
        return view
    }
}
