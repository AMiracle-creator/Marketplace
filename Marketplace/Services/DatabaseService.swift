//
//  DatabaseService.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 09.02.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol DatabaseServiceProtocol {
    func getUser(completion: @escaping((Result<MarketplaceUser, Error>) -> Void))
    func setPublication(publication: Publication, image: Data, completion: @escaping((Result<Publication, Error>) -> Void))
    func getPublications(by userID: String?, completion: @escaping((Result<[Publication], Error>) -> Void))
    func getCategories(completion: @escaping((Result<[Categories], Error>) -> Void))
}

class DatabaseService: DatabaseServiceProtocol { 
    
    static let shared = DatabaseService()
    
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    private var publicationsRef: CollectionReference {
        return db.collection("publications")
    }
    
    private var categoriesRef: CollectionReference {
        return db.collection("categories")
    }
    
//    private init () {}
    
    func setUser(user: MarketplaceUser, completion: @escaping((Result<MarketplaceUser, Error>) -> Void)) {
        usersRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func getUser(completion: @escaping((Result<MarketplaceUser, Error>) -> Void)) {
        usersRef.document(Auth.auth().currentUser!.uid).getDocument { docSnapshot, error in
            guard let docSnapshot = docSnapshot else { return }
            
            guard let data = docSnapshot.data() else { return }
            
            guard let id = data["id"] as? String else { return }
            guard let userName = data["username"] as? String else { return }
            guard let email = data["email"] as? String else { return }
            
            let user = MarketplaceUser(id: id, username: userName, email: email)
            
            completion(.success(user))
        }
    }
    
    func setPublication(publication: Publication, image: Data, completion: @escaping((Result<Publication, Error>) -> Void)) {
        StorageSerivce.shared.uploadPublicationImage(pulicationID: publication.id, image: image) { result in
            switch result {
            case .success(let imageSize):
                print(imageSize)
                
                self.publicationsRef.document(publication.id).setData(publication.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(publication))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Use this function without arguments to get all available publications.
    func getPublications(by userID: String?, completion: @escaping((Result<[Publication], Error>) -> Void)) {
        publicationsRef.getDocuments { qSnap, error in
            if let qSnap = qSnap {
                
                var publications = [Publication]()
                let dispatchGroup = DispatchGroup()
                
                for doc in qSnap.documents {
                    
                    if var publication = Publication(doc: doc) {
                        
                        dispatchGroup.enter()
                        
                        StorageSerivce.shared.downloadPublicationImage(pulicationID: publication.id) { result in
                            
                            switch result {
                            case.success(let data):
                                let img = UIImage(data: data)
                                publication.image = img

                                if let userID = userID {
                                    if publication.userID == userID {
                                        publications.append(publication)
                                    }
                                } else {
                                    publications.append(publication)
                                }
                                
                            case.failure(let error):
                                print(error.localizedDescription)
                            }
                            
                            dispatchGroup.leave()
                        }
                    }
                }
                dispatchGroup.notify(queue: .global()) {
                    completion(.success(publications))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func getCategories(completion: @escaping((Result<[Categories], Error>) -> Void)) {
        categoriesRef.getDocuments { qSnap, error in
            if let qSnap = qSnap {
                var categories = [Categories]()
                for doc in qSnap.documents {
                    if let category = Categories(doc: doc) {
                        categories.append(category)
                    }
                }
                completion(.success(categories))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}
