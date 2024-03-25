//
//  AppCoordinator.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 19.03.2024.
//

import Foundation
import UIKit
import FirebaseAuth

final class AppCoordinator: BaseCoordinator {
    
    private var window: UIWindow
    
    private var navigationController: UINavigationController = {
        let controller = UINavigationController()
        return controller
    }()
    
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    override func start() {

        switch isLoggedIn() {
        case true:
            openMainScreen()
        case false:
            openLoginScreen()
        }
    }
    
    func openLoginScreen() {
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let authCoordinator = AuthCoordinator(navigationController: navigationController, flowListener: self)
        authCoordinator.start()
        
        add(coordinator: authCoordinator)
    }
    
    func openMainScreen() {

        let tabBarCoordinator = TabBarCoordinator(flowListener: self)
        window.rootViewController = tabBarCoordinator.start()
        window.makeKeyAndVisible()
        
        add(coordinator: tabBarCoordinator)
    }
    
    private func isLoggedIn() -> Bool {
        if Auth.auth().currentUser == nil {
            return false
        }

        return true
    }
}

extension AppCoordinator: CoordinatorFlowListener {
    func onFlowFinished(coordinator: Coordinator) {
        remove(coordinator: coordinator)
        
        if coordinator is TabBarCoordinator {
            window.rootViewController = nil
        }

        switch isLoggedIn() {
        case true:
            openMainScreen()
        case false:
            openLoginScreen()
        }
        
//        switch isLoggedIn() {
//        case true:
//            openMainScreen()
//        case false:
//            openLoginScreen()
//        }
    }
}
