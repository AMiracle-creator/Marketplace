//
//  UICollectionViewLayout+Extension.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 02.03.2024.
//

import UIKit

extension UICollectionViewLayout {
    
    static var mainScreen: UICollectionViewLayout {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch MainSections.dataSection(for: sectionIndex) {
            case .categories:
                return Self.categorySection()
            case .main:
                return Self.mainSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20.0
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    static var errorScreen: UICollectionViewCompositionalLayout {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            return Self.mainSection()
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20.0
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    private static func mainSection() -> NSCollectionLayoutSection {
           let spacing: CGFloat = 10
           let itemSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1.0),
               heightDimension: .fractionalHeight(1.0))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           
           let groupSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1.0),
               heightDimension: .fractionalWidth(0.7))
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
           group.interItemSpacing = .fixed(spacing)
           
           let section = NSCollectionLayoutSection(group: group)
//           section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
           section.interGroupSpacing = spacing
           
           return section
       }

    private static func categorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(80),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(90),
            heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(16)
      
        
        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 8
        
        return section
    }
    
    static var profileScreen: UICollectionViewLayout {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch ProfileSections.dataSection(for: sectionIndex) {
            case .main:
                return Self.profileSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20.0
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    private static func profileSection() -> NSCollectionLayoutSection {
        let spacing: CGFloat = 10
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = spacing
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        section.supplementariesFollowContentInsets = true
        
        return section
    }
    
    private static func supplementaryHeaderItem() ->  NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    private static var footerButtonItem: NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(80)
        )
     
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
    }
}
