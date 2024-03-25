//
//  LoginController.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 22.12.2023.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    var presenter: LoginViewOutput
    
    // MARK: - UI Components
    
    private let headerView = AuthHeaderView(title: "Авторизация", subTitle: "Авторизуйтесь в свой аккаунт или создайте новый")
    
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    
    private let signInButton = CustomButton(title: "Войти", hasBackground: true, fontSize: .big)
    private let newUserButton = CustomButton(title: "Новый пользователь? Создайте аккаунт.", fontSize: .medium)
    private let forgotPasswordButton = CustomButton(title: "Забыли пароль?", fontSize: .small)
    
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
    
    init(presenter: LoginViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
        self.forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signInButton)
        self.view.addSubview(newUserButton)
        self.view.addSubview(forgotPasswordButton)
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIConstants.headerViewHeight)
        }
        
        emailField.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(UIConstants.bigOffset)
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
        
        signInButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(UIConstants.bigOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.customTextFieldHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
        
        newUserButton.snp.makeConstraints {
            $0.top.equalTo(signInButton.snp.bottom).offset(UIConstants.mediumOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.secondaryButtonHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
        
        forgotPasswordButton.snp.makeConstraints {
            $0.top.equalTo(newUserButton.snp.bottom).offset(UIConstants.smallOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.secondaryButtonHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
    }
    
    // MARK: - Selectors
    
    @objc private func didTapSignIn() {
        let email = self.emailField.text ?? ""
        let password = self.passwordField.text ?? ""
        
        presenter.didTapSignIn(email: email, password: password)
    }
    
    @objc private func didTapNewUser() {
        presenter.didTapNewUser()
    }
    
    @objc private func didTapForgotPassword() {
        presenter.didTapForgotPassword()
    }
 
}

// MARK: - LoginViewInput Extension

extension LoginController: LoginViewInput {
    func updateView(alertManager: AlertManager, error: Error) {
        alertManager.showSignInErrorAlert(on: self, with: error)
    }
}
