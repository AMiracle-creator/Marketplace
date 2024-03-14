//
//  PublicationDetailAssembly.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 11.03.2024.
//

import Foundation
import UIKit

protocol PublicationDetailAssemblyProtocol {
    func assemble(publication: Publication) -> UIViewController
}

final class PublicationDetailAssembly: PublicationDetailAssemblyProtocol {
    func assemble(publication: Publication) -> UIViewController {
        let router = PublicationDetailRouter()
        let presenter = PublicationDetailPresenter(router: router, publication: publication)
        let view = PublicationDetailViewController(presenter: presenter)
        presenter.view = view
        router.transitionHandler = view
        return view
    }
}
