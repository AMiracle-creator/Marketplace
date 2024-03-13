//
//  RegisteruserRequest.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 18.01.2024.
//

import Foundation

struct MarketplaceUser: Identifiable {
    var id: String
    var username: String
    var email: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["username"] = self.username
        repres["email"] = self.email
        return repres
    }
}
