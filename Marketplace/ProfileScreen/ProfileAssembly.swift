//
//  ProfileAssembly.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 18.02.2024.
//

import Foundation
import UIKit

protocol ProfileAssemblyProtocol {
    func assemble(coordinator: ProfileScreenCoordinatorOutput) -> UIViewController
}

final class ProfileAssembly: ProfileAssemblyProtocol {
    func assemble(coordinator: ProfileScreenCoordinatorOutput) -> UIViewController {
        let databaseService = DatabaseService()
        let alertManager = AlertManager()
        let authService = AuthService()
        let presenter = ProfilePresenter(databaseService: databaseService, authService: authService, alertManager: alertManager, coordinator: coordinator)
        let view = ProfileViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
