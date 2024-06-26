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
    var categories = [Categories]()
    var selectedRow = 0
    
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
    
    private let cityField = CustomTextField(fieldType: .city)
    
    private let pickerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitle("Категория", for: .normal)
        button.tintColor = .lightGray
        button.setTitleColor(.gray, for: .normal)
        return button
    }()


    private let placeHolder = "Описание"
    
    private let descriptionField: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .left
        textView.textColor = .lightGray
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 10
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 8, bottom: 8, right: 8)
        return textView
    }()
    
    private let addPublicationButton = CustomButton(title: "Добавить обьявление", hasBackground: true, fontSize: .medium)
    
    // MARK: - Private Constants
    private enum UIConstants {
        static let smallOffset: CGFloat = 8
        static let mediumOffset: CGFloat = 16
        static let bigOffset: CGFloat = 24
        static let customTextFieldHeight: CGFloat = 55
        static let customTextFieldWidthMultiplier = 0.85
        static let imageViewHeight: CGFloat = 200
        static let descriptionFieldHeight: CGFloat = 120
        static let screenWidth = UIScreen.main.bounds.width - 10
        static let screenHeight = UIScreen.main.bounds.height / 2
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
        self.presenter.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        pickerButton.addTarget(self, action: #selector(popUpPicker), for: .touchUpInside)
        addPublicationButton.addTarget(self, action: #selector(didTapAddPublication), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAddImage))
        imageView.addGestureRecognizer(tapGesture)
        
        self.view.addSubview(imageView)
        self.view.addSubview(titleField)
        self.view.addSubview(descriptionField)
        self.view.addSubview(priceField)
        self.view.addSubview(cityField)
        self.view.addSubview(addPublicationButton)
        self.view.addSubview(pickerButton)
        
        descriptionField.delegate = self
        descriptionField.text = placeHolder
        
        imageView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(UIConstants.bigOffset)
            $0.height.equalTo(UIConstants.imageViewHeight)
        }
        
        titleField.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(UIConstants.mediumOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.customTextFieldHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
        
        priceField.snp.makeConstraints {
            $0.top.equalTo(titleField.snp.bottom).offset(UIConstants.mediumOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.customTextFieldHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
        
        pickerButton.snp.makeConstraints {
            $0.top.equalTo(priceField.snp.bottom).offset(UIConstants.mediumOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.customTextFieldHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
        
        cityField.snp.makeConstraints {
            $0.top.equalTo(pickerButton.snp.bottom).offset(UIConstants.mediumOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.customTextFieldHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
        
        descriptionField.snp.makeConstraints {
            $0.top.equalTo(cityField.snp.bottom).offset(UIConstants.mediumOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.descriptionFieldHeight)
            $0.width.equalTo(priceField.snp.width)
        }
        
        addPublicationButton.snp.makeConstraints {
            $0.top.equalTo(descriptionField.snp.bottom).offset(UIConstants.mediumOffset)
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
                                      category: pickerButton.titleLabel?.text ?? "Не указано",
                                      city: cityField.text ?? "Не указано",
                                      createdAt: Date())
        
        presenter.createPublicationButtonPressed(publication: publication, image: imageData)
    }
    
    @objc private func popUpPicker() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: UIConstants.screenWidth, height:  UIConstants.screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: UIConstants.screenWidth, height: UIConstants.screenHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
            
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
    
        let alert = UIAlertController(title: "Выберите категорию товара", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = pickerButton
        alert.popoverPresentationController?.sourceRect = pickerButton.bounds
                
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { (UIAlertAction) in }))
                
        alert.addAction(UIAlertAction(title: "Выбрать", style: .default, handler: { (UIAlertAction) in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            let selected = self.categories[self.selectedRow]
            let name = selected.name
            self.pickerButton.setTitle(name, for: .normal)
            self.pickerButton.setTitleColor(.black, for: .normal)
        }))
                
        self.present(alert, animated: true, completion: nil)
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
    func updateView(with categories: [Categories]) {
        self.categories = categories
    }
    
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

extension PublicationCreationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIConstants.screenWidth, height: 30))
        label.text = categories[row].name
        label.sizeToFit()
        return label
    }
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categories.count
    }
        
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
}
