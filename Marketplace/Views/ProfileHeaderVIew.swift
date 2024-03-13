//
//  ProfileHeaderVIew.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 02.02.2024.
//

import UIKit

class ProfileHeaderVIew: UIView {
    // MARK: - UI Components
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "profile")
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 70
        image.clipsToBounds = true
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font  = .systemFont(ofSize: 26, weight: .bold)
        label.text = "Error"
        return label
    }()
    
    // MARK: - Private constants
    private enum UIConstants {
        static let imageSize: CGFloat = 136
    }
    
    // MARK: - LifeCycle
    
    init(title: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.addSubview(profileImageView)
        self.addSubview(titleLabel)
        
        profileImageView.snp.makeConstraints {
            $0.size.equalTo((CGSize(width: UIConstants.imageSize, height: UIConstants.imageSize)))
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(32)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func configire(title: String) {
        titleLabel.text = title
    }
}
