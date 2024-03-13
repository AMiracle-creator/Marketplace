//
//  AuthService.swift
//  Marketplace
//
//  Created by Амир Гайнуллин on 18.01.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol AuthServiceProtocol: AnyObject {
    func signUp(username: String, email: String, password: String, complition: @escaping(Result<User, Error>) -> Void)
    func signIn(email: String, password: String , completion: @escaping(Result<User, Error>)->Void)
    func signOut(completion: @escaping(Error?)->Void)
    func forgotPassword(email: String, complition: @escaping(Error?) -> Void)
}

class AuthService: AuthServiceProtocol {
   
    public static let shared = AuthService()
    
//    private init () {}
    
    func signUp(username: String, email: String, password: String, complition: @escaping(Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let result = result {
                let marketplaceUser = MarketplaceUser(id: result.user.uid, username: username, email: email)
                
                DatabaseService.shared.setUser(user: marketplaceUser) { resultDB in
                    switch resultDB  {
                    case .success(_):
                        complition(.success(result.user))
                    case .failure(let error):
                        complition(.failure(error))
                    }
                }
            } else if let error = error {
                complition(.failure(error))
            }
        }
    }
    
    public func signUp(username: String, email: String, password: String, complition: @escaping(Bool, Error?)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                complition(false, error)
                return
            }

            guard let resultUser = result?.user else {
                complition(false, nil)
                return
            }

            let marketplaceUser = MarketplaceUser(id: resultUser.uid, username: username, email: email)
            
            DatabaseService.shared.setUser(user: marketplaceUser) { resultDB in
                switch resultDB  {
                case .success(_):
                    complition(true, nil)
                case .failure(let error):
                    complition(false, error)
                }
            }
        }
    }
    
    func signIn(email: String, password: String , completion: @escaping(Result<User, Error>)->Void) {
        Auth.auth().signIn(withEmail: email, password: password) {result, error in
            if let result = result {
                completion(.success(result.user))
                return
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func signOut(completion: @escaping(Error?)->Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    func forgotPassword(email: String, complition: @escaping(Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            complition(error)
        }
    }
}
