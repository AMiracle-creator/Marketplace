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
    
    // MARK: UI Components
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let publicationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let publicationPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let createdTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
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
    
    // MARK: UI Setup
    private func setupUI() {
        self.addSubview(imageView)
        self.addSubview(publicationTitleLabel)
        self.addSubview(publicationPriceLabel)
        self.addSubview(createdTimeLabel)
        
        imageView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        
        publicationTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(UIConstants.defaultInset)
        }

        publicationPriceLabel.snp.makeConstraints {
            $0.top.equalTo(publicationTitleLabel.snp.bottom).offset(UIConstants.defaultInset)
            $0.leading.trailing.equalToSuperview()
        }
        
        createdTimeLabel.snp.makeConstraints {
            $0.top.equalTo(publicationPriceLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: Public functions
    func configure(with publication: Publication) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM, HH:mm"
        
        imageView.image = publication.image
        publicationTitleLabel.text = publication.title
        publicationPriceLabel.text = publication.price + "₽"
        createdTimeLabel.text = dateFormatter.string(from: publication.createdAt)
    }
}

