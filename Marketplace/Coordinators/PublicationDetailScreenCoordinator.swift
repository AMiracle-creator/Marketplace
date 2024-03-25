//
//  PublicationDetailScreenCoordinator.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 24.03.2024.
//

//import Foundation
//import UIKit
//
//protocol PublicationDetailScreenCoordinatorOutput: AnyObject {
//    func anotherFlow()
//}
//
//class PublicationDetailScreenCoordinator: BaseCoordinator {
//    
//    var navigationController: UINavigationController
//    var publication: Publication?
//    weak var flowListener: CoordinatorFlowListener?
//    
//    init(navigationController: UINavigationController, publication: Publication) {
//        self.navigationController = navigationController
//        self.publication = publication
//    }
//    
//    override func start() {
//        guard let publication = publication else { return }
//        
//        let publicationDetailController = PublicationDetailAssembly().assemble(publication: publication, coordinator: self)
//        navigationController.pushViewController(publicationDetailController, animated: true)
//    }
//}
//
//// MARK: - CoordinatorFlowListener
//
//extension PublicationDetailScreenCoordinator: CoordinatorFlowListener {
//    func onFlowFinished(coordinator: Coordinator) {
//        remove(coordinator: self)
//        
//        flowListener?.onFlowFinished(coordinator: self)
//    }
//}
//
//// MARK: - MainScreenCoordinatorOutput
//
//extension PublicationDetailScreenCoordinator: PublicationDetailScreenCoordinatorOutput {
//    func anotherFlow() {
//        // to do
//    }
//}
