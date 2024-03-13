//
//  PublicationCollectionViewCell.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 27.01.2024.
//

import Foundation
import UIKit

class PublicationCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "PublicationCollectionViewCell"
    
    // MARK: - UI Components
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
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
        
        imageView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        
        publicationTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(UIConstants.defaultInset)
        }

        publicationCostLabel.snp.makeConstraints {
            $0.top.equalTo(publicationTitleLabel.snp.bottom).offset(UIConstants.defaultInset)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(4)
        }
    }
    
    // MARK: - Public functions
    func configure(with image: UIImage, title: String) {
        imageView.image = image
        publicationTitleLabel.text = title
    }
}

