//
//  TabBarCoordinator.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 21.03.2024.
//

import Foundation
import UIKit

final class TabBarCoordinator: BaseCoordinator {
    
    var rootViewController: UIViewController = UITabBarController()
    var mainScreenCoordinator = MainScreenCoordinator(navigationController: UINavigationController())
    var profileScreenCoordinator = ProfileScreenCoordinator(navigationController: UINavigationController())
    weak var flowListener: CoordinatorFlowListener?
    
    init(flowListener: CoordinatorFlowListener) {
        self.flowListener = flowListener
    }
    
    func start() -> UIViewController {
        mainScreenCoordinator.start()
        profileScreenCoordinator.start()
        
        let mainScreenController = mainScreenCoordinator.navigationController
        mainScreenCoordinator.flowListener = self
        mainScreenController.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        add(coordinator: mainScreenCoordinator)
            
        let profileScreenController = profileScreenCoordinator.navigationController
        profileScreenCoordinator.flowListener = self
        profileScreenController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.fill"), tag: 1)
        add(coordinator: profileScreenCoordinator)
        
        (rootViewController as? UITabBarController)?.viewControllers = [mainScreenController, profileScreenController]
        return rootViewController
    }
}

// MARK: - CoordinatorFlowListener

extension TabBarCoordinator: CoordinatorFlowListener {
    func onFlowFinished(coordinator: Coordinator) {
        remove(coordinator: self)
        
        flowListener?.onFlowFinished(coordinator: self)
    }
}
