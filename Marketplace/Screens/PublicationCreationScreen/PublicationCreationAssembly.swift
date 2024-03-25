//
//  PublicationCreationAssembly.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 18.02.2024.
//

import Foundation
import UIKit

protocol PublicationCreationAssemblyProtocol {
    func assemble(marketplaceUser: MarketplaceUser, coordinator: ProfileScreenCoordinatorOutput) -> UIViewController
}

final class PublicationCreationAssembly: PublicationCreationAssemblyProtocol {
    func assemble(marketplaceUser: MarketplaceUser, coordinator: ProfileScreenCoordinatorOutput) -> UIViewController {
        let databaseService = DatabaseService()
        let presenter = PublicationCreationPresenter(databaseService: databaseService, marketplaceUser: marketplaceUser, coordinator: coordinator)
        let view = PublicationCreationViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
