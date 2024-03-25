//
//  MainScreenCoordinator.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 23.03.2024.
//

import Foundation
import UIKit

protocol MainScreenCoordinatorOutput: AnyObject {
    func openDetail(publication: Publication)
}

class MainScreenCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController
    weak var flowListener: CoordinatorFlowListener?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let mainController = MainAssembly().assemble(coordinator: self)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(mainController, animated: true)
    }
}

// MARK: - CoordinatorFlowListener

extension MainScreenCoordinator: CoordinatorFlowListener {
    func onFlowFinished(coordinator: Coordinator) {
        remove(coordinator: self)
        
        flowListener?.onFlowFinished(coordinator: self)
    }
}

// MARK: - MainScreenCoordinatorOutput

extension MainScreenCoordinator: MainScreenCoordinatorOutput {
    func openDetail(publication: Publication) {
        let detailController = PublicationDetailAssembly().assemble(publication: publication)
        navigationController.pushViewController(detailController, animated: true)
    }
}
