//
//  PublicationCreationControllerViewController.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 08.02.2024.
//

import UIKit
import SnapKit

class PublicationCreationViewController: UIViewController {
    
    var presenter: PublicationCreationViewOutput
    
    // MARK: - UI Components
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.isUserInteractionEnabled = true
        image.image = UIImage(named: "placeholder")
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private let titleField = CustomTextField(fieldType: .title)
    private let priceField = CustomTextField(fieldType: .price)
    
    private let placeHolder = "Описание"
    
    private let descriptionField: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .left
        textView.textColor = .lightGray
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 10
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 8)
        return textView
    }()
    
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
    
    init(presenter: PublicationCreationViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        view.addSubview(descriptionField)
        view.addSubview(priceField)
        view.addSubview(addPublicationButton)
        
        descriptionField.delegate = self
        descriptionField.text = placeHolder
        
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
        
        priceField.snp.makeConstraints {
            $0.top.equalTo(titleField.snp.bottom).offset(UIConstants.bigOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.customTextFieldHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
        
        descriptionField.snp.makeConstraints {
            $0.top.equalTo(priceField.snp.bottom).offset(UIConstants.bigOffset)
            $0.leading.trailing.equalToSuperview().inset(UIConstants.bigOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(110)
            $0.width.equalTo(priceField.snp.width)
        }
        
        addPublicationButton.snp.makeConstraints {
            $0.top.equalTo(descriptionField.snp.bottom).offset(UIConstants.bigOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.customTextFieldHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        
        guard let currentUser = presenter.marketplaceUser else { return }
        
        let publication = Publication(userID: currentUser.id,
                                      username: currentUser.username,
                                      title: titleField.text ?? "Не указано",
                                      description: descriptionField.text ?? "Не указано",
                                      price: priceField.text ?? "Не указано",
                                      createdAt: Date())

        presenter.createPublicationButtonPressed(publication: publication, image: imageData)
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

extension PublicationCreationViewController: PublicationCreationViewInput {
    func updateState() {
        print("Loading...")
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

extension PublicationCreationViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == placeHolder && descriptionField.textColor == .lightGray) {
            textView.text = ""
            textView.textColor = .black
        }
        
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeHolder
            textView.textColor = .lightGray
        }
        
        textView.resignFirstResponder()
    }
}
