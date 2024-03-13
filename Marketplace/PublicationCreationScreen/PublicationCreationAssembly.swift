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
        let view = PublicationCreationViewController()
        let databaseService = DatabaseService()
        let router = PublicationCreationRouter(transitionHandler: view)
        let presenter = PublicationCreationPresenter(view: view, router: router, databaseService: databaseService, marketplaceUser: marketplaceUser)
        view.publicationCreationPresenter = presenter
        return view
    }
}
