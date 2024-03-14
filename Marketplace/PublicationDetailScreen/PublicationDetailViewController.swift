//
//  PublicationDetailViewController.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 11.03.2024.
//

import UIKit
import SnapKit

class PublicationDetailViewController: UIViewController {
    
    private let presenter: PublicationDetailViewOutput
    
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
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let descriptionText: UITextView = {
        let textView = UITextView()
        textView.text = "Это большой объем текста, который будет отображаться в UITextView. UITextView обеспечивает прокрутку, чтобы пользователи могли просматривать весь текст.Это большой объем текста, который будет отображаться в UITextView. UITextView обеспечивает прокрутку, чтобы пользователи могли просматривать весь текст."
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = false
        textView.delaysContentTouches = false
        textView.isScrollEnabled = false
        textView.textColor = .label
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        return textView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Даня"
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let createdTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "11 марта 2024, 17:34"
        label.textColor = .gray
        return label
    }()
    
    private let ratingStarsView: UIView = {
        let view = UIView()
        // Здесь можно добавить звезды, например, изображения или настроенные UIViews
        // Для простоты, давайте добавим просто текстовые звезды
        let starLabel = UILabel()
        starLabel.text = "⭐️⭐️⭐️⭐️"
        view.addSubview(starLabel)
        starLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return view
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "Рейтинг: 4.5"
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
    
    init(presenter: PublicationDetailViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        self.view.addSubview(ratingLabel)
        self.view.addSubview(ratingStarsView)
        
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
        
        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(UIConstants.smallOffset)
            $0.leading.equalToSuperview().inset(UIConstants.bigOffset)
        }
            
        ratingStarsView.snp.makeConstraints {
            $0.centerY.equalTo(ratingLabel.snp.centerY)
            $0.leading.equalTo(ratingLabel.snp.trailing).offset(UIConstants.smallOffset)
            $0.trailing.lessThanOrEqualToSuperview().inset(UIConstants.bigOffset)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(ratingLabel.snp.bottom).offset(UIConstants.bigOffset)
            $0.leading.trailing.equalToSuperview().inset(UIConstants.bigOffset)
        }
        
        descriptionText.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(UIConstants.mediumOffset)
            $0.leading.trailing.equalToSuperview().inset(UIConstants.bigOffset)
            $0.height.equalTo(heightForView(text: descriptionText.text, font: descriptionText.font ?? UIFont.systemFont(ofSize: 16), width: UIScreen.main.bounds.width - 2 * UIConstants.bigOffset))
        }
        
        createdTimeLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionText.snp.bottom).offset(UIConstants.bigOffset)
            $0.leading.trailing.equalToSuperview().inset(UIConstants.bigOffset)
        }
    }
    
    // MARK: - Privater methods
    
    private func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: .infinity)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: font]
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
        return estimatedFrame.height
    }
}

// MARK: - Extensions

extension PublicationDetailViewController: PublicationDetailViewInput {
    func updateView(with publicastion: Publication) {
        print("123")
    }
}
