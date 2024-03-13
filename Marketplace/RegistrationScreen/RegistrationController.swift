//
//  RegistrationController.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 22.12.2023.
//

import UIKit

class RegistrationController: UIViewController {
    
    var presenter: RegistrationViewOutput
    
    // MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Регистрация", subTitle: "Создание нового аккаунта")
    
    private let nameField = CustomTextField(fieldType: .username)
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    
    private let signUpButton = CustomButton(title: "Зарегистрироваться", hasBackground: true, fontSize: .big)
    private let signInButton = CustomButton(title: "Уже есть аккаунт? Войти", fontSize: .medium)
    
    private let termsTextView: UITextView = {
        let attributedString = NSMutableAttributedString(string: "Создовая аккаунт, Вы соглашаетесь с нашей политикой конфиденциальности и условиями пользования")
        
        attributedString.addAttribute(.link, value: "privacy://privacyPolicy", range: (attributedString.string as NSString).range(of: "политикой конфиденциальности"))
        
        attributedString.addAttribute(.link, value: "terms://termsAndConditions", range: (attributedString.string as NSString).range(of: "условиями пользования"))
        
        let textView = UITextView()
        textView.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        textView.backgroundColor = .clear
        textView.attributedText = attributedString
        textView.textColor = .label
        textView.isSelectable = true
        textView.isEditable = false
        textView.delaysContentTouches = false
        textView.isScrollEnabled = false
        textView.textAlignment = .center

        return textView
    }()
    
    //MARK: - Private Constants
    private enum UIConstants {
        static let smallOffset: CGFloat = 8
        static let mediumOffset: CGFloat = 16
        static let bigOffset: CGFloat = 24
        static let headerViewHeight: CGFloat = 222
        static let customTextFieldHeight: CGFloat = 55
        static let secondaryButtonHeight: CGFloat = 44
        static let customTextFieldWidthMultiplier = 0.85
    }
    
    //MARK: - LifeCycle
    
    init(presenter: RegistrationViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.termsTextView.delegate = self
        
        self.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(headerView)
        self.view.addSubview(nameField)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signUpButton)
        self.view.addSubview(termsTextView)
        self.view.addSubview(signInButton)
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIConstants.headerViewHeight)
        }
        
        nameField.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(UIConstants.bigOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.customTextFieldHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
        
        emailField.snp.makeConstraints {
            $0.top.equalTo(nameField.snp.bottom).offset(UIConstants.bigOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.customTextFieldHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
        
        passwordField.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(UIConstants.bigOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.customTextFieldHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(UIConstants.bigOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.customTextFieldHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
        
        termsTextView.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(UIConstants.smallOffset)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
        
        signInButton.snp.makeConstraints {
            $0.top.equalTo(termsTextView.snp.bottom).offset(UIConstants.smallOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.secondaryButtonHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
    }
    
    //MARK: - Selectors
    @objc private func didTapSignUp() {
        let username = self.nameField.text ?? ""
        let email = self.emailField.text ?? ""
        let password = self.passwordField.text ?? ""
        
        presenter.didTapSignUp(username: username, email: email, password: password)
        
//        AuthService.shared.signUp(username: username, email: email, password: password) { [weak self] wasRegistred, error in
//            guard let self = self else { return }
//            if let error = error {
//                AlertManager.showRegistrationErrorAlert(on: self, with: error)
//                return
//            }
//            
//            if wasRegistred {
//                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
//                    sceneDelegate.checkAuthenticaton()
//                } else {
//                    AlertManager.showRegistrationErrorAlert(on: self)
//                }
//            }
//        }
    }
    
    @objc private func didTapSignIn() {
        presenter.didTapSignIn()
    }
}

//MARK: - UITextViewDelegate

extension RegistrationController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if URL.scheme == "privacy" {
            self.showWebViewerController(with: "https://policies.google.com/privacy?hl=ru")
            print("политика")
        } else if URL.scheme == "terms" {
            self.showWebViewerController(with: "https://policies.google.com/terms?hl=ru")
            print("условия")
        }
        
        return true
    }
    
    private func showWebViewerController(with url: String) {
        let viewController = WebViewerController(with: url)
        let nav = UINavigationController(rootViewController: viewController)
        self.present(nav, animated: true, completion: nil)
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.delegate = nil
        textView.selectedTextRange = nil
        textView.delegate = self
    }
}

// MARK: - Extensions

extension RegistrationController: RegistrationViewInput {
    func updateView(alertManager: AlertManager, error: Error) {
        alertManager.showRegistrationErrorAlert(on: self, with: error)
    }
}
