//
//  StorageService.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 19.02.2024.
//

import Foundation
import FirebaseStorage

class StorageSerivce {
    static let shared = StorageSerivce()
    
    private let storage = Storage.storage().reference()
    private var publicationsRef: StorageReference { storage.child("publications") }
    
    private init() {}
    
    func uploadPublicationImage(pulicationID: String, image: Data, completion: @escaping(Result<String, Error>) -> Void) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        publicationsRef.child(pulicationID).putData(image, metadata: metadata) { metadata, error in
            guard let metadata = metadata else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success("Image size \(metadata.size)"))
        }
    }
    
    func downloadPublicationImage(pulicationID: String, completion: @escaping(Result<Data, Error>) -> Void) {
        publicationsRef.child(pulicationID).getData(maxSize: 2 * 1024 * 1024) { data, error in
            guard let data = data else {
                if let error = error{
                    completion(.failure(error))
                }
                return
            }
            
            completion(.success(data))
        }
    }
}
