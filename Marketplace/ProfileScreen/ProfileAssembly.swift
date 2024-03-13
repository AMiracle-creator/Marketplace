//
//  ProfileAssembly.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 18.02.2024.
//

import Foundation
import UIKit

protocol ProfileAssemblyProtocol {
    func assemble() -> UIViewController
}

final class ProfileAssembly: ProfileAssemblyProtocol {
    func assemble() -> UIViewController {
        let databaseService = DatabaseService()
        let alertManager = AlertManager()
        let authService = AuthService()
        let router = ProfileRouter()
        let presenter = ProfilePresenter(databaseService: databaseService, authService: authService, alertManager: alertManager, router: router)
        let view = ProfileViewController(presenter: presenter)
        presenter.view = view
        router.transitionHandler = view
        return view
    }
}
