//
//  ProfileRouter.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 18.02.2024.
//

import Foundation
import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func presentPublicationCreationScreen(marketplaceUser: MarketplaceUser)
    func presentLoginScreen()
}

class ProfileRouter: ProfileRouterProtocol {
    weak var transitionHandler: UIViewController?
    private let publicationCreationAssembly = PublicationCreationAssembly()
    private let loginAssembly = LoginAssembly()
    
    func presentPublicationCreationScreen(marketplaceUser: MarketplaceUser) {
        if let transitionHandler = transitionHandler {
            let publicationCreatioViewController = publicationCreationAssembly.assemble(marketplaceUser: marketplaceUser)
            transitionHandler.navigationController?.present(publicationCreatioViewController, animated: true)
        }
    }
    
    func presentLoginScreen() {
        if let transitionHandler = transitionHandler {
            let loginViewController = loginAssembly.assemble()
            transitionHandler.navigationController?.pushViewController(loginViewController, animated: true)
        }
    }
}
