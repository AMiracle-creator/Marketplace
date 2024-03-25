//
//  PublicationDetailPresnter.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 11.03.2024.
//

import Foundation

protocol PublicationDetailViewInput: AnyObject {
    func updateView(with publication: Publication)
}

protocol PublicationDetailViewOutput: AnyObject {
    func viewDidLoad()
}

class PublicationDetailPresenter: PublicationDetailViewOutput {
    weak var view: PublicationDetailViewInput?
    let publication: Publication
    
    init(publication: Publication) {
        self.publication = publication
    }
    
    // MARK: - MainViewOutput
    
    func viewDidLoad() {
        view?.updateView(with: self.publication)
    }
}
