 //  AuthHeaderView.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 23.12.2023.
//

import UIKit
import SnapKit

class AuthHeaderView: UIView {
    // MARK: - UI Components
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "logo")
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
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Error"
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Private constants
    private enum UIConstants {
        static let logoSize: CGFloat = 90
    }
    
    // MARK: - LifeCycle
    
    init(title: String, subTitle: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.addSubview(logoImageView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        logoImageView.snp.makeConstraints {
            $0.size.equalTo((CGSize(width: UIConstants.logoSize, height: UIConstants.logoSize)))
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(30)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(19)
            $0.leading.trailing.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
