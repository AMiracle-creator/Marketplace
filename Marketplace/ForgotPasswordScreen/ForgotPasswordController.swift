//
//  ForgotPasswordController.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 14.01.2024.
//

import UIKit
import SnapKit

class ForgotPasswordController: UIViewController {
    
    var presenter: ForgotPasswordViewOutput
    
    //MARK: - UI Components
    
    private let headerView = AuthHeaderView(title: "Забыли пароль", subTitle: "Востановить пароль")
    
    private let emailField = CustomTextField(fieldType: .email)
    
    private let resetPasswordButton = CustomButton(title: "Подтвердить", hasBackground: true, fontSize: .big)
    
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
    
    //MARK:  - LifeCycle
    
    init(presenter: ForgotPasswordViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.resetPasswordButton.addTarget(self, action: #selector(didTapResetPassword), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - UI Setup
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(resetPasswordButton)
        
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
        
        resetPasswordButton.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(UIConstants.bigOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIConstants.customTextFieldHeight)
            $0.width.equalToSuperview().multipliedBy(UIConstants.customTextFieldWidthMultiplier)
        }
    }
    
    //MARK: - Selectors
    
    @objc private func didTapResetPassword() {
        let email = self.emailField.text ?? ""
        
        presenter.didTapResetPassword(email: email)
//        AuthService.shared.forgotPassword(email: email) { [weak self] error in
//            guard let self = self else { return }
//            if let error = error {
//                AlertManager.showErrorSendingPasswordResetAlert(on: self, with: error)
//                return
//            }
//            
//            AlertManager.showPasswordResetSentAlert(on: self)
//        }
    }
}

extension ForgotPasswordController: ForgotPasswordInput {
    func updateView(alertManager: AlertManager, error: Error?) {
        if let error = error {
            alertManager.showRegistrationErrorAlert(on: self, with: error)
        } else {
            alertManager.showPasswordResetSentAlert(on: self)
        }
    }
}
