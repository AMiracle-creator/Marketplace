//
//  MainTabBarAssembly.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 05.03.2024.
//

import Foundation
import UIKit

protocol MainTabBarAssemblyProtocol {
    func assemble() -> UITabBarController
}

final class MainTabBarAssembly: MainTabBarAssemblyProtocol {
    func assemble() -> UITabBarController {
        let view = MainTabBarController()
        return view
    }
}

