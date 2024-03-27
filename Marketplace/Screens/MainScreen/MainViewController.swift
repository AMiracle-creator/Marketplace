//
//  MainViewController.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 24.01.2024.
//

import UIKit
import SnapKit

private typealias DataSource = UICollectionViewDiffableDataSource<MainSections, ItemMain>

class MainViewController: UIViewController {
    
    private let presenter: MainViewOutput
    private lazy var dataSource: DataSource = {
        let dataSource = configureDataSource()
        let initialSnapshot = dataSource.snapshot()
        return dataSource
    }()
    
    // MARK: UI Components
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .mainScreen)
        collectionView.register(PublicationCollectionViewCell.self, forCellWithReuseIdentifier: "PublicationCollectionViewCell")
        collectionView.register(HorizontalMenuCollectionViewCell.self, forCellWithReuseIdentifier: "HorizontalMenuCollectionViewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: LifeCycle
    
    init(presenter: MainViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        self.setupUI()
        self.presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: SearchController Setup
    
    private func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Поиск"
        self.searchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: Configuring DataSource
    
    private func configureDataSource() -> DataSource {
        
        DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .publications(let publication):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PublicationCollectionViewCell.reuseIdentifier, for: indexPath) as? PublicationCollectionViewCell else { fatalError("Cannot create the cell") }
        
                cell.configure(with: publication.image!, title: publication.title)
                
                return cell
            case .category(let category):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalMenuCollectionViewCell.reuseIdentifier, for: indexPath) as? HorizontalMenuCollectionViewCell else { fatalError("Cannot create the cell") }

                cell.configure(with: category.name)
                
                return cell
                
            case .loading:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
                cell.backgroundColor = .systemGray
                cell.layer.cornerRadius = 16
                return cell
                
            case .error:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
                cell.backgroundColor = .red
                cell.layer.cornerRadius = 16
                return cell
            }
        }
    }
}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {
    
    func updateView(with sections: [MainSections]) {
        var snapshot = NSDiffableDataSourceSnapshot<MainSections, ItemMain>()
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
            
        presenter.viewDidSelectItem(item)
    }
}

// MARK: - UISearchResultsUpdating

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter.filterContent(queryOrNil: searchController.searchBar.text)
    }
}
