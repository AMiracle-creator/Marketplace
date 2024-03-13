//
//  PublicationCreationPresenter.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 15.02.2024.
//

import Foundation

protocol PublicationCreationViewProtocol: AnyObject {
    func updateState(isCreated state: Bool)
    func failure(error: Error)
}

protocol PublicationCreationViewPresenterProtocol: AnyObject {
    init(view: PublicationCreationViewController, router: PublicationCreationRouter?, databaseService: DatabaseServiceProtocol, marketplaceUser: MarketplaceUser?)
    func createPublicationButtonPressed(publication: Publication, image: Data)
}

class PublicationCreationPresenter: PublicationCreationViewPresenterProtocol {
    weak var view: PublicationCreationViewProtocol?
    let router: PublicationCreationRouter?
    let databaseService: DatabaseServiceProtocol!
    var marketplaceUser: MarketplaceUser?
    
    required init(view: PublicationCreationViewController, router: PublicationCreationRouter?, databaseService: DatabaseServiceProtocol, marketplaceUser: MarketplaceUser?) {
        self.view = view
        self.router = router
        self.databaseService = databaseService
        self.marketplaceUser = marketplaceUser
    }
    
    func dismissView() {
        router?.dismissView()
    }
    
    func createPublicationButtonPressed(publication: Publication, image: Data) {
        self.view?.updateState(isCreated: false)
        databaseService.setPublication(publication: publication, image: image) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let publication):
                print(publication.title)
                self.view?.updateState(isCreated: true)
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
}
