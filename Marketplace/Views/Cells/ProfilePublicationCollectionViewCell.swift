//
//  ProfilePublicationCollectionViewCell.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 05.02.2024.
//

import UIKit

class ProfilePublicationCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ProfilePublicationCollectionViewCell"
    
    // MARK: - UI Components
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        return image
    }()
    
    private let publicationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title dsfaffsdfsdfsdfsdsdfsdfsdfsdfsd"
        return label
    }()
    
    private let publicationCostLabel: UILabel = {
        let label = UILabel()
        label.text = "1000"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    // MARK: - Private Constants
    private enum UIConstants {
        static let defaultInset: CGFloat = 8
    }
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.addSubview(imageView)
        self.addSubview(publicationTitleLabel)
        self.addSubview(publicationCostLabel)
        
        publicationTitleLabel.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        publicationCostLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        imageView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalTo(imageView.snp.height)
        }
        
        publicationTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
        }

        publicationCostLabel.snp.makeConstraints {
            $0.top.equalTo(publicationTitleLabel.snp.bottom)
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(4)
        }
    }
    
    // MARK: - Public functions
    func configure(with image: UIImage, title: String) {
        imageView.image = image
        publicationTitleLabel.text = title
    }
}


