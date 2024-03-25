//
//  ProfileScreenCoordinator.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 23.03.2024.
//

import Foundation
import UIKit

protocol ProfileScreenCoordinatorOutput: AnyObject {
    func openPublicationCreation(marketplaceUser: MarketplaceUser)
    func closePublicationCreation()
    func openDetail(publication: Publication)
    func changeFlow()
}

class ProfileScreenCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController
    weak var flowListener: CoordinatorFlowListener?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let profileController = ProfileAssembly().assemble(coordinator: self)
        navigationController.pushViewController(profileController, animated: true)
    }
}

// MARK: - CoordinatorFlowListener

extension ProfileScreenCoordinator: CoordinatorFlowListener {
    func onFlowFinished(coordinator: Coordinator) {
        remove(coordinator: self)
        
        flowListener?.onFlowFinished(coordinator: self)
    }
}

// MARK: - MainScreenCoordinatorOutput

extension ProfileScreenCoordinator: ProfileScreenCoordinatorOutput {
    func openPublicationCreation(marketplaceUser: MarketplaceUser) {
        let publicationCreationController = PublicationCreationAssembly().assemble(marketplaceUser: marketplaceUser, coordinator: self)
        navigationController.present(publicationCreationController, animated: true)
    }
    
    func closePublicationCreation() {
        navigationController.dismiss(animated: true)
    }
    
    func openDetail(publication: Publication) {
        let detailController = PublicationDetailAssembly().assemble(publication: publication)
        navigationController.pushViewController(detailController, animated: true)
    }
    
    func changeFlow() {
        onFlowFinished(coordinator: self)
        
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
}
