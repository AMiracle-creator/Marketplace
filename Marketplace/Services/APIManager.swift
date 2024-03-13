//
//  APIManager {.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 23.01.2024.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseFirestore

class APIManger {
    
    static let shared = APIManger()
    
    private func configureFB() -> Firestore {
        var db: Firestore!
        let settings  = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    func getPost(collection: String, postName: String) {
        
    }
}
