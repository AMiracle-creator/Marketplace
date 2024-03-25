//
//  CoordinatorFactory.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 19.03.2024.
//

import Foundation
final class CoordinatorFactory {
    fileprivate let modulesFactory = ModulesFactory()
}
 
extension CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeAuthorizationCoordinator(with router: Routable) -> Coordinatable & AuthorizationCoordinatorOutput {
        return AuthorizationCoordinator(router: router, factory: modulesFactory)
    }
}
