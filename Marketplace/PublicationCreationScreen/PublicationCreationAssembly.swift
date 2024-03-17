//
//  PublicationCreationAssembly.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 18.02.2024.
//

import Foundation
import UIKit

protocol PublicationCreationAssemblyProtocol {
    func assemble(marketplaceUser: MarketplaceUser) -> UIViewController
}

final class PublicationCreationAssembly: PublicationCreationAssemblyProtocol {
    func assemble(marketplaceUser: MarketplaceUser) -> UIViewController {
        let databaseService = DatabaseService()
        let router = PublicationCreationRouter()
        let presenter = PublicationCreationPresenter(router: router, databaseService: databaseService, marketplaceUser: marketplaceUser)
        let view = PublicationCreationViewController(presenter: presenter)
        presenter.view = view
        router.transitionHandler = view
        return view
    }
}
