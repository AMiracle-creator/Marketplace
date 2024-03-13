//
//  MainAssembly.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 26.02.2024.
//

import Foundation
import UIKit

protocol MainAssemblyProtocol {
    func assemble() -> UIViewController
}

final class MainAssembly: MainAssemblyProtocol {
    func assemble() -> UIViewController {
        let databaseService = DatabaseService()
        let router = MainRouter()
        let presenter = MainViewPresenter(databaseService: databaseService, router: router)
        let view = MainViewController(presenter: presenter)
        presenter.view = view
        router.transitionHandler = view
        return view
    }
}
