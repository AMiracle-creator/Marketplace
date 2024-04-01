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
    var userename: String
    var title: String
    var description: String
    var price: String
    var category: String
    var city: String
    var createdAt: Date
    var image: UIImage?
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["userID"] = userID
        repres["username"] = userename
        repres["title"] = title
        repres["description"] = description
        repres["price"] = price
        repres["category"] = category
        repres["city"] = city
        repres["createdAt"] = Timestamp(date: createdAt)
        return repres
    }
    
    init(id: String = UUID().uuidString, userID: String, username: String, title: String, description: String, price: String, category: String, city: String, createdAt: Date) {
        self.id = id
        self.userID = userID
        self.userename = username
        self.title = title
        self.description = description
        self.price = price
        self.category = category
        self.city = city
        self.createdAt = createdAt
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String else { return nil }
        guard let userID = data["userID"] as? String else { return nil }
        guard let username = data["username"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let description = data["description"] as? String else { return nil }
        guard let price = data["price"] as? String else { return nil }
        guard let category = data["category"] as? String else { return nil }
        guard let city = data["city"] as? String else { return nil }
        guard let createdAt = data["createdAt"] as? Timestamp else { return nil }
        
        self.id = id
        self.userID = userID
        self.userename = username
        self.title = title
        self.description = description
        self.price = price
        self.category = category
        self.city = city
        self.createdAt = createdAt.dateValue()
    }
}
