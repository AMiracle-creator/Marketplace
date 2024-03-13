//
//  HomeViewController.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 22.12.2023.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    // MARK: - UI Components
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Loading..."
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
         
//         AuthService.shared.fetchUser { [weak self] user, error in
//              guard let self = self else { return }
//              if let error = error {
//                   AlertManager.showFetchingUserErrorAlert(on: self, with: error)
//                   return
//              }
//              
//              if let user = user {
//                   self.label.text = "\(user.username)/n\(user.email)"
//              }
//         }
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
        
        self.view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Selectors
    @objc private func didTapLogout() {
         AuthService.shared.signOut { [weak self] error in
              guard let self = self else { return }
              if let error  = error {
                   AlertManager().showLogoutErrorAlert(on: self, with: error)
                   return
              }
              
              if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
//                   sceneDelegate.checkAuthenticaton()
              }
         }
    }
}
