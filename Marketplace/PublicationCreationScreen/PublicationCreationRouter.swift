//
//  PublicationCreationRouter.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 17.02.2024.
//

import Foundation
import UIKit

protocol PublicationCreationRouterProtocol {
    func dismissView()
}

class PublicationCreationRouter: PublicationCreationRouterProtocol {
    weak var transitionHandler: UIViewController?
    
    func dismissView() {
        transitionHandler?.dismiss(animated: true, completion: nil)
    }
}
