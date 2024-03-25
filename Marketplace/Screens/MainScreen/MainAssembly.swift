//
//  MainAssembly.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 26.02.2024.
//

import Foundation
import UIKit

protocol MainAssemblyProtocol {
    func assemble(coordinator: MainScreenCoordinatorOutput) -> UIViewController
}

final class MainAssembly: MainAssemblyProtocol {
    func assemble(coordinator: MainScreenCoordinatorOutput) -> UIViewController {
        let databaseService = DatabaseService()
        let presenter = MainViewPresenter(databaseService: databaseService, coordinator: coordinator)
        let view = MainViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
