//
//  MainTabBarController.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 02.02.2024.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
    }
    
    private func generateTabBar() {
        let searchViewController = MainAssembly().assemble()
        let profileViewController = ProfileAssembly().assemble()
        
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        
        searchNavigationController.tabBarItem.title = "Поиск"
        searchNavigationController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        profileNavigationController.tabBarItem.title = "Профиль"
        profileNavigationController.tabBarItem.image = UIImage(systemName: "person.fill")
        
        viewControllers = [searchNavigationController, profileNavigationController]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
}
