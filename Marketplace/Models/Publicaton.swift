//
//  Post.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 23.01.2024.
//

import Foundation
import FirebaseFirestore

struct Publication: Identifiable, Hashable {
    var id = UUID().uuidString
    var userID: String
    var title: String
    var description: String
    var price: String
    var createdAt: Date
    var image: UIImage?
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["userID"] = userID
        repres["title"] = title
        repres["description"] = description
        repres["price"] = price
        repres["createdAt"] = Timestamp(date: createdAt)
        return repres
    }
    
    init(id: String = UUID().uuidString, userID: String, title: String, description: String, price: String, createdAt: Date) {
        self.id = id
        self.userID = userID
        self.title = title
        self.description = description
        self.price = price
        self.createdAt = createdAt
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String else { return nil }
        guard let userID = data["userID"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let description = data["description"] as? String else { return nil }
        guard let price = data["price"] as? String else { return nil }
        guard let createdAt = data["createdAt"] as? Timestamp else { return nil }
        
        self.id = id
        self.userID = userID
        self.title = title
        self.description = description
        self.price = price
        self.createdAt = createdAt.dateValue()
    }
}
