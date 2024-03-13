//
//  FooterSupplementaryView.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 06.02.2024.
//

import Foundation
import UIKit
import SnapKit

class FooterSupplementaryView: UICollectionReusableView {
    
    static let reuseIdentifier = "footer"
    // MARK: - UI Components
    private let newPublicatonButton = CustomButton(title: "Разместить обьявление", hasBackground: true, fontSize: .medium)
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .none
        self.addSubview(newPublicatonButton)
        
        newPublicatonButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(16)
        }
    }
}

