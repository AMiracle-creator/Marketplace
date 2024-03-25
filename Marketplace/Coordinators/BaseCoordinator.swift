//
//  BaseCoordinator.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 19.03.2024.
//

import Foundation

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    func start() {
        fatalError("Child should emplement funcStart")
    }
}
