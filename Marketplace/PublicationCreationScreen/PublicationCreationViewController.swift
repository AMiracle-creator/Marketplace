//
//  PublicationCreationControllerViewController.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 08.02.2024.
//

import UIKit
import SnapKit

class PublicationCreationViewController: UIViewController {
    var publicationCreationPresenter: PublicationCreationPresenter!
    // MARK: - UI Components
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.isUserInteractionEnabled = true
        image.image = UIImage(named: "dog")
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private let titleField = CustomTextField(fieldType: .title)
    private let descriptionFiled = CustomTextField(fieldType: .description)
    private let priceField = CustomTextField(fieldType: .price)
    
    private let addPublicationButton = CustomButton(title: "Добавить обьявление", hasBackground: true, fontSize: .medium)
    
    // MARK: - Private Constants
    private enum UIConstants {
        static let smallOffset: CGFloat = 8
        static let mediumOffset: CGFloat = 16
        static let bigOffset: CGFloat = 24
        static let headerViewHeight: CGFloat = 222
        static let customTextFieldHeight: CGFloat = 55
        static let secondaryButtonHeight: CGFloat = 44
        static let customTextFieldWidthMultiplier = 0.85
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
            
        setupUI()
        
        addPublicationButton.addTarget(self, action: #selector(didTapAddPublication), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAddImage))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(titleField)
        view.addSubview(descriptionFiled)
        view.addSubview(priceField)
        view.addSubview(addPublicationButton)
        
        imageView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(UIConstants.bigOffset)
            $0.height.equalTo(200)
        }
        
        titleField.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(UIConstants.bigOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.customTextFieldHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
        
        descriptionFiled.snp.makeConstraints {
            $0.top.equalTo(titleField.snp.bottom).offset(UIConstants.bigOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.customTextFieldHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
        
        priceField.snp.makeConstraints {
            $0.top.equalTo(descriptionFiled.snp.bottom).offset(UIConstants.bigOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.customTextFieldHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
        
        addPublicationButton.snp.makeConstraints {
            $0.top.equalTo(priceField.snp.bottom).offset(UIConstants.bigOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.customTextFieldHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
    }
    
    // MARK: - Selectors
    @objc private func didTapAddImage() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc private func didTapAddPublication() {
        guard let imageData = imageView.image?.jpegData(compressionQuality: 0.15) else { return }
        
        let publication = Publication(userID: publicationCreationPresenter.marketplaceUser!.id,
                                      title: titleField.text ?? "Не указано",
                                      description: descriptionFiled.text ?? "Не указано",
                                      price: priceField.text ?? "Не указано",
                                      createdAt: Date())

        publicationCreationPresenter.createPublicationButtonPressed(publication: publication, image: imageData)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension PublicationCreationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension PublicationCreationViewController: PublicationCreationViewProtocol {
    func updateState(isCreated state: Bool) {
        if state == true {
            publicationCreationPresenter.router?.dismissView()
        }
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
