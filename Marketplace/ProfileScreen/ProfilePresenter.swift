//
//  ProfilePresenter.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 12.02.2024.
//

import Foundation

protocol ProfileViewInput: AnyObject {
    func updateUserInfo(with username: String)
    func updateUserPublications(with sections: [ProfileSections])
    func showAlert(alertManager: AlertManager, error: Error)
}

protocol ProfileViewOutput: AnyObject {
    func viewDidLoad()
    func viewDidSelectItem(_ item: Item)
    func tapOnPublicationCreation(marketplaceUser: MarketplaceUser)
    func didTapLogout()
    var user: MarketplaceUser? { get set }
}

class ProfilePresenter: ProfileViewOutput {
    weak var view: ProfileViewInput?
    let databaseService: DatabaseServiceProtocol?
    let authService: AuthServiceProtocol?
    let alertManager: AlertManager?
    let coordinator: ProfileScreenCoordinatorOutput?
    var router: ProfileRouterProtocol?
    var user: MarketplaceUser?
    var publicationsCells = [Item]()
    
    init(databaseService: DatabaseServiceProtocol, authService: AuthServiceProtocol, alertManager: AlertManager, router: ProfileRouterProtocol, coordinator: ProfileScreenCoordinatorOutput) {
        self.router = router
        self.databaseService = databaseService
        self.authService = authService
        self.alertManager = alertManager
        self.coordinator = coordinator
    }
    
    // MARK: - MainViewOutput
    func viewDidLoad() {
        view?.updateUserPublications(with: [.mainLoading])
        loadData()
    }
    
    func viewDidSelectItem(_ item: Item) {
        switch item {
        case .publications(let publication):
//            router?.presentDetailView(with: publication)
            coordinator?.openDetail(publication: publication)
        case .loading(_), .error(_):
            break
        }
    }
    
    func tapOnPublicationCreation(marketplaceUser: MarketplaceUser) {
//        router?.presentPublicationCreationScreen(marketplaceUser: marketplaceUser)
        coordinator?.openPublicationCreation(marketplaceUser: marketplaceUser)
    }
    
    func didTapLogout() {
        authService?.signOut { [weak self] error in
            guard let self = self else { return }
            guard let alertManager = alertManager else { return }
            
            if let error = error {
                self.view?.showAlert(alertManager: alertManager, error: error)
                return
            }
            
            coordinator?.changeFlow()
        }
    }
    
    // MARK: - Private methods
    
    private func loadData() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        getUser { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.user = user
                
                dispatchGroup.enter()
                self.getUsersPublicationItems { [weak self] result in
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let items):
                        self.publicationsCells = items
                        
                    case .failure(let erorr):
                        print(erorr.localizedDescription)
                    }
                    dispatchGroup.leave()
                }
                
            case .failure(let erorr):
                print(erorr.localizedDescription)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self else { return }
            guard let user = user else { return }
            
            self.view?.updateUserInfo(with: user.username)
            self.view?.updateUserPublications(with: [.main(self.publicationsCells)])
        }
    }
    
    private func getUser(completion: @escaping(Result<MarketplaceUser, Error>) -> Void) {
        databaseService?.getUser { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getUsersPublicationItems(completion: @escaping(Result<[Item], Error>) -> Void) {
        databaseService?.getPublications(by: user?.id) { result in
            switch result {
            case .success(let pubs):
                let items = pubs.map { Item.publications($0) }
                completion(.success(items))
//                    self.view?.updateUserPublications(with: [.main(items)])
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
