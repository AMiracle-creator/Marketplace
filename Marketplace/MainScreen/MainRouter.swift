//
//  MainRouter.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 26.02.2024.
//

import Foundation
import UIKit

protocol MainRouterProtocol: AnyObject {
    func presentDetailView(with publication: Publication)
}

class MainRouter: MainRouterProtocol {
    weak var transitionHandler: UIViewController?
//    private let publicationDetailAssembly =
    
    
    func presentDetailView(with publication: Publication) {
        print("123")
    }
}
