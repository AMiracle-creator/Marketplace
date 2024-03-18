//
//  PublicationCreationPresenter.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 15.02.2024.
//

import Foundation

protocol PublicationCreationViewInput: AnyObject {
    func updateState()
    func failure(error: Error)
}

protocol PublicationCreationViewOutput: AnyObject {
    func createPublicationButtonPressed(publication: Publication, image: Data)
    var marketplaceUser: MarketplaceUser? { get set }
}

class PublicationCreationPresenter: PublicationCreationViewOutput {
    weak var view: PublicationCreationViewInput?
    let router: PublicationCreationRouter?
    let databaseService: DatabaseServiceProtocol?
    var marketplaceUser: MarketplaceUser?
    
    required init(router: PublicationCreationRouter?, databaseService: DatabaseServiceProtocol, marketplaceUser: MarketplaceUser?) {
        self.router = router
        self.databaseService = databaseService
        self.marketplaceUser = marketplaceUser
    }
    
    func dismissView() {
        router?.dismissView()
    }
    
    func createPublicationButtonPressed(publication: Publication, image: Data) {
        self.view?.updateState()
        databaseService?.setPublication(publication: publication, image: image) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let publication):
                print(publication.title)
                self.dismissView()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    private func getCategoryItems(completion: @escaping(Result<[ItemMain], Error>) -> Void) {
        databaseService?.getCategories { result in
            switch result {
            case .success(let categories):
                let items = categories.map { ItemMain.category($0) }
                completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
