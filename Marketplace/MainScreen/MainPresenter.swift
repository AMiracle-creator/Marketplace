//
//  MainPresenter.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 24.01.2024.
//

import Foundation

protocol MainViewInput: AnyObject {
    func updateView(with sections: [MainSections])
}

protocol MainViewOutput: AnyObject {
    func viewDidLoad()
    func viewDidSelectItem(_ item: ItemMain)
}

class MainViewPresenter: MainViewOutput {
    weak var view: MainViewInput?
    var router: MainRouterProtocol?
    let databaseService: DatabaseServiceProtocol!
    var categoriesCells = [ItemMain]()
    var publicationsCells = [ItemMain]()
    
    init(databaseService: DatabaseServiceProtocol, router: MainRouterProtocol) {
        self.router = router
        self.databaseService = databaseService
    }
    
    // MARK: - MainViewOutput
    
    func viewDidLoad() {
        view?.updateView(with: [.categoriesLoading, .mainLoading])
        loadData()
    }
    
    func viewDidSelectItem(_ item: ItemMain) {
        switch item {
        case .publications(let publication):
            router?.presentDetailView(with: publication)
        case .category(let category):
            print("Selected category: \(category.name)")
        case .loading, .error:
            break
        }
    }
    
    // MARK: Privat methods
    
    private func loadData() {
        let dispatchGroup = DispatchGroup()
        var isError = false
        
        dispatchGroup.enter()
        getCategoryItems { [weak self] result in
            switch result {
            case .success(let items):
                self?.categoriesCells = items
                
            case .failure(let erorr):
                print(erorr.localizedDescription)
                isError = true
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getPublicationItmes { [weak self] result in
            switch result {
            case .success(let items):
                self?.publicationsCells = items
                
            case .failure(let erorr):
                print(erorr.localizedDescription)
                isError = true
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self else { return }
            
            guard !isError else {
                self.view?.updateView(with: [.sectionError])
                return
            }
            
            self.view?.updateView(with: [
                .categories(self.categoriesCells),
                .main(self.publicationsCells)
            ])
        }
    }
    
    private func getPublicationItmes(completion: @escaping(Result<[ItemMain], Error>) -> Void) {
        databaseService.getPublications(by: nil) { result in
                switch result {
                case .success(let pubs):
                    let items = pubs.map { ItemMain.publications($0) }
                    completion(.success(items))
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
    
    private func getCategoryItems(completion: @escaping(Result<[ItemMain], Error>) -> Void) {
        databaseService.getCategories { result in
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
