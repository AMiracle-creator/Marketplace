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
        let presenter = PublicationDetailPresenter(publication: publication)
        let view = PublicationDetailViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
