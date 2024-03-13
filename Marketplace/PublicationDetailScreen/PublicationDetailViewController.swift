//
//  PublicationDetailViewController.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 11.03.2024.
//

import UIKit
import SnapKit

class PublicationDetailViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "dog")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "1000 ₽"
        label.font = .boldSystemFont(ofSize: 40)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Собака забавная"
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание"
        return label
    }()
    
    private let descriptionText: UITextView = {
        let textView = UITextView()
        textView.text = "Это большой объем текста, который будет отображаться в UITextView. UITextView обеспечивает прокрутку, чтобы пользователи могли просматривать весь текст."
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Даня"
        return label
    }()
    
    private let createdTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "11 марта 2024, 17:34"
        return label
    }()
    
    // MARK: - Private constants
    
    private enum UIConstants {
        static let smallOffset: CGFloat = 8
        static let mediumOffset: CGFloat = 16
        static let bigOffset: CGFloat = 24
        static let imageViewHeight: CGFloat = 320
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(imageView)
        self.view.addSubview(priceLabel)
        self.view.addSubview(titleLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(descriptionText)
        self.view.addSubview(usernameLabel)
        self.view.addSubview(createdTimeLabel)
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIConstants.imageViewHeight)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(UIConstants.bigOffset)
            $0.leading.trailing.equalToSuperview().inset(UIConstants.bigOffset)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(UIConstants.mediumOffset)
            $0.leading.trailing.equalToSuperview().inset(UIConstants.bigOffset)
        }
        
        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIConstants.bigOffset)
            $0.leading.trailing.equalToSuperview().inset(UIConstants.bigOffset)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(UIConstants.bigOffset)
            $0.leading.trailing.equalToSuperview().inset(UIConstants.bigOffset)
        }
        
        descriptionText.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(UIConstants.mediumOffset)
            $0.leading.trailing.equalToSuperview().inset(UIConstants.bigOffset)
            $0.height.equalTo(100)
        }
        
        createdTimeLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionText.snp.bottom).offset(UIConstants.bigOffset)
            $0.leading.trailing.equalToSuperview().inset(UIConstants.bigOffset)
        }
    }
}
