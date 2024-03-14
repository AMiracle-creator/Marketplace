//
//  PublicationDetailRouter.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 11.03.2024.
//

import Foundation
import UIKit

protocol PublicationDetailRouterProtocol {
    func dismissView()
}

class PublicationDetailRouter: PublicationDetailRouterProtocol {
    weak var transitionHandler: UIViewController?
    
    func dismissView() {
        transitionHandler?.dismiss(animated: true, completion: nil)
    }
}
