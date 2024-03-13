//
//  ProfileSectionsAndItems.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 20.02.2024.
//

import Foundation
import UIKit

enum ProfileSections: Hashable {
    case main([Item])
}

extension ProfileSections {
    var items: [Item] {
        switch self {
        case .main(let items):
            return items
        }
    }
}

enum Item: Hashable {
    case publications(Publication)
    case loading(Int)
    case error(Int)
}

extension ProfileSections {
    
    static var mainLoading: Self = {
        .main([.loading(0), .loading(1), .loading(2)])
    }()
    
    
    static var sectionError: Self = {
        .main([.error(0)])
    }()
    
    static func dataSection(for index: Int) -> Self {
        switch index {
        case 0:
            return .main([])
        default:
            return .main([])
        }
    }
}
