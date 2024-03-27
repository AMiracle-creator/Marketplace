//
//  ViewController.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 02.02.2024.
//

import UIKit

private typealias DataSource = UICollectionViewDiffableDataSource<ProfileSections, Item>

class ProfileViewController: UIViewController {
    
    var presenter: ProfileViewOutput
    private lazy var dataSource: DataSource = configureDataSource()
    private var currentData: [ProfileSections] = []
    
    // MARK: - UI Copmponents
    
    private let profileHeaderView = ProfileHeaderVIew(title: "User")
    
    private let refreshControl = UIRefreshControl()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .profileScreen)
        collectionView.register(ProfilePublicationCollectionViewCell.self, forCellWithReuseIdentifier: ProfilePublicationCollectionViewCell.reuseIdentifier)
        collectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSupplementaryView.reuseIdentifier)
        collectionView.register(FooterSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterSupplementaryView.reuseIdentifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.refreshControl = self.refreshControl
        return collectionView
    }()
    
    private let newPublicationButton = CustomButton(title: "Разместить обьявление", hasBackground: true, fontSize: .medium)
    
    // MARK: - Private Constants
    
    private enum UIConstants {
        static let profielHeaderViewHeight: CGFloat = 200
    }
    
    // MARK: - LifeCycle
    
    init(presenter: ProfileViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.configureHeader()
        self.presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false

    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
        
        self.newPublicationButton.addTarget(self, action: #selector(didTapNewPublication), for: .touchUpInside)
        self.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        self.view.addSubview(profileHeaderView)
        self.view.addSubview(collectionView)
        self.view.addSubview(newPublicationButton)
        
        profileHeaderView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIConstants.profielHeaderViewHeight)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(profileHeaderView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        
        newPublicationButton.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(8)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            $0.height.equalTo(50)
        }
    }
    
    private func configureDataSource() -> DataSource {
        DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .publications(let publication):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfilePublicationCollectionViewCell.reuseIdentifier, for: indexPath) as? ProfilePublicationCollectionViewCell else { fatalError("Cannot create the cell") }
        
                cell.configure(with: publication.image!, title: publication.title)
                
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
    
    private func configureHeader() {
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderSupplementaryView.reuseIdentifier, for: indexPath) as! HeaderSupplementaryView
                
                header.confugire(text: "Мои обьявления")
                return header
            case UICollectionView.elementKindSectionFooter:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterSupplementaryView.reuseIdentifier, for: indexPath) as! FooterSupplementaryView
                return footer
            default:
                return nil
            }
        }
    }
    
    // MARK: - Selectors
    
    @objc private func didTapNewPublication() {
        presenter.tapOnPublicationCreation(marketplaceUser: presenter.user!)
    }
    
    @objc private func didTapLogout() {
        presenter.didTapLogout()
    }
    
    @objc private func refreshData() {
        presenter.refreshData()
    }
}

// MARK: - ProfileViewInput extension

extension ProfileViewController: ProfileViewInput {
    func updateUserPublications(with sections: [ProfileSections]) {
        var snapshot = NSDiffableDataSourceSnapshot<ProfileSections, Item>()
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
        
        refreshControl.endRefreshing()
    }

    func updateUserInfo(with username: String) {
        profileHeaderView.configire(title: username)
    }
    
    func showAlert(alertManager: AlertManager, error: Error) {
        alertManager.showLogoutErrorAlert(on: self, with: error)
    }
}

// MARK: - UICollectionViewDelegate

extension ProfileViewController: UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
            
        presenter.viewDidSelectItem(item)
    }
}
