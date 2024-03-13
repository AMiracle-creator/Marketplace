//
//  HorizontalMenuCollectionViewCell.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 29.01.2024.
//

import Foundation
import UIKit
import SnapKit

class HorizontalMenuCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "HorizontalMenuCollectionViewCell"
    
    // MARK: - UI Components
    let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Arial Bold", size: 18)
        return label
    }()
    
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
        self.backgroundColor = .systemBlue
        layer.cornerRadius = 10
        
        self.addSubview(categoryNameLabel)
        
        categoryNameLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
    
    public func configure(with text: String) {
        categoryNameLabel.text = text
    }
}
