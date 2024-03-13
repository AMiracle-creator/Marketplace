//
//  Categories.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 27.02.2024.
//

import Foundation
import FirebaseFirestore

struct Categories: Hashable {
//    var id: String
    var name: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
//        repres["id"] = id
        repres["name"] = name
        return repres
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
//        guard let id = data["id"] as? String else { return nil }
        guard let name = data["name"] as? String else { return nil }
      
//        self.id = id
        self.name = name
    }
}
