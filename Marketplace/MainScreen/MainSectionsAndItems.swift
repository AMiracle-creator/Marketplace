//
//  MainSectionsAndItems.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 26.02.2024.
//

import Foundation
import UIKit

enum MainSections: Hashable {
    case main([ItemMain])
    case categories([ItemMain])
}

extension MainSections {
    var items: [ItemMain] {
        switch self {
        case .main(let items), .categories(let items):
            return items
        }
    }
}

enum ItemMain: Hashable {
    case publications(Publication)
    case category(Categories)
    case loading(Int)
    case error(Int)
}

extension MainSections {
    
    static var mainLoading: Self = {
        .main([.loading(0), .loading(1), .loading(2), .loading(3), .loading(4), .loading(5)])
    }()
    
    static var categoriesLoading: Self = {
        .categories([.loading(6), .loading(7), .loading(8), .loading(9), .loading(10)])
    }()
    
    static var sectionError: Self = {
        .main([.error(0)])
    }()
    
    static func dataSection(for index: Int) -> Self {
        switch index {
        case 0:
            return .categories([])
        case 1:
            return .main([])
            
        default:
            return .main([])
        }
    }
}
