//
//  PublicationCreationPresenter.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 15.02.2024.
//

import Foundation

protocol PublicationCreationViewInput: AnyObject {
    func updateState()
    func updateView(with categories: [Categories])
    func failure(error: Error)
}

protocol PublicationCreationViewOutput: AnyObject {
    func createPublicationButtonPressed(publication: Publication, image: Data)
    func viewDidLoad()
    var marketplaceUser: MarketplaceUser? { get set }
}

class PublicationCreationPresenter: PublicationCreationViewOutput {
    weak var view: PublicationCreationViewInput?
    let databaseService: DatabaseServiceProtocol?
    let coordinator: ProfileScreenCoordinatorOutput?
    var marketplaceUser: MarketplaceUser?
    
    required init(databaseService: DatabaseServiceProtocol, marketplaceUser: MarketplaceUser?, coordinator: ProfileScreenCoordinatorOutput) {
        self.databaseService = databaseService
        self.marketplaceUser = marketplaceUser
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        getCategories()
    }
    
    func createPublicationButtonPressed(publication: Publication, image: Data) {
        self.view?.updateState()
        databaseService?.setPublication(publication: publication, image: image) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let publication):
                print(publication.title)
                coordinator?.closePublicationCreation()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    private func getCategories() {
        databaseService?.getCategories { result in
            switch result {
            case .success(let categories):
                self.view?.updateView(with: categories)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
