//
//  NetworkService.swift
//  Social Welfare
//
//  Created by Luis Franzoni on 11/5/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import Foundation
import FirebaseFirestore
import CodableFirebase

class NetworkService {
    
    class func getObject<T: Codable>(from url:String, _ completion: @escaping (ResultRequest<T>) -> Void) {
        let db = Firestore.firestore().document(url)
        db.getDocument { (document, error) in
            if let err = error {
                let serviceError = ServiceError.customError(message: err.localizedDescription)
                #if DEBUG
                print("::: Error getting documents: \(serviceError.localizedDescription)")
                #endif
                completion(.failure(serviceError))
                return
            }
            if let document = document, document.exists, let data = document.data() {
                do {
                    let modelData = try FirestoreDecoder().decode(T.self, from: data)
                    completion(.success(modelData))
                    return
                } catch {
                    #if DEBUG
                    print("::: Couldn't parse de model: \(document.documentID)")
                    print(error)
                    #endif
                }
                completion(.failure(ServiceError.invalidData))
            } else {
                completion(.failure(ServiceError.notFoundData))
            }
        }
    }
    
    class func getObjects<T: Codable>(from url:String, parameters: [String: String] = [:], _ completion: @escaping (ResultRequest<[T]>) -> Void) {
        let db = Firestore.firestore().collection(url)
        for (key, value) in parameters {
            db.whereField(key, isEqualTo: value)
        }
        
        db.getDocuments() { (querySnapshot, error) in
            if let err = error {
                let serviceError = ServiceError.customError(message: err.localizedDescription)
                #if DEBUG
                print("::: Error getting documents: \(serviceError.localizedDescription)")
                #endif
                completion(.failure(serviceError))
                return
            }
            var array: [T] = []
            for document in querySnapshot!.documents {
                #if DEBUG
                print("::: Results: \(document.documentID) => \(document.data())")
                #endif
                do {
                    let modelData = try FirestoreDecoder().decode(T.self, from: document.data())
                    array.append(modelData)
                } catch {
                    #if DEBUG
                    print("::: Couldn't parse de model: \(document.documentID)")
                    print(error)
                    #endif
                }
            }
            completion(.success(array))
        }
    }
    
    class func listenToObjects<T: Codable>(from url:String, parameters: [String: String] = [:], _ completion: @escaping (ResultRequest<[T]>) -> Void) {
        let db = Firestore.firestore().collection(url)
        for (key, value) in parameters {
            db.whereField(key, isEqualTo: value)
        }
        
        db.addSnapshotListener { (querySnapshot, error) in
            if let err = error {
                let serviceError = ServiceError.customError(message: err.localizedDescription)
                #if DEBUG
                print("::: Error getting documents: \(serviceError.localizedDescription)")
                #endif
                completion(.failure(serviceError))
                return
            }
            var array: [T] = []
            for document in querySnapshot!.documents {
                #if DEBUG
                print("::: Results: \(document.documentID) => \(document.data())")
                #endif
                do {
                    let modelData = try FirestoreDecoder().decode(T.self, from: document.data())
                    array.append(modelData)
                } catch {
                    #if DEBUG
                    print("::: Couldn't parse de model: \(document.documentID)")
                    print(error)
                    #endif
                }
            }
            completion(.success(array))
        }
    }
    
    class func getCollection<T: Codable>(from url:String, _ completion: @escaping (ResultRequest<[String:T]>) -> Void) {
        let db = Firestore.firestore().collection(url)
        db.getDocuments() { (querySnapshot, error) in
            if let err = error {
                let serviceError = ServiceError.customError(message: err.localizedDescription)
                #if DEBUG
                print("::: Error getting documents: \(serviceError.localizedDescription)")
                #endif
                completion(.failure(serviceError))
                return
            }
            var collection: [String: T] = [:]
            for document in querySnapshot!.documents {
                #if DEBUG
                print("::: Results: \(document.documentID) => \(document.data())")
                #endif
                do {
                    let modelData = try FirestoreDecoder().decode(T.self, from: document.data())
                    collection[document.documentID] = modelData
                } catch {
                    #if DEBUG
                    print("::: Couldn't parse de model: \(document.documentID)")
                    print(error)
                    #endif
                }
            }
            completion(.success(collection))
        }
    }
    
    class func listenToCollection<T: Codable>(from url:String, _ completion: @escaping (ResultRequest<[String:T]>) -> Void) {
        let db = Firestore.firestore().collection(url)
        db.addSnapshotListener() { (querySnapshot, error) in
            if let err = error {
                let serviceError = ServiceError.customError(message: err.localizedDescription)
                #if DEBUG
                print("::: Error getting documents: \(serviceError.localizedDescription)")
                #endif
                completion(.failure(serviceError))
                return
            }
            var collection: [String: T] = [:]
            for document in querySnapshot!.documents {
                #if DEBUG
                print("::: Results: \(document.documentID) => \(document.data())")
                #endif
                do {
                    let modelData = try FirestoreDecoder().decode(T.self, from: document.data())
                    collection[document.documentID] = modelData
                } catch {
                    #if DEBUG
                    print("::: Couldn't parse de model: \(document.documentID)")
                    print(error)
                    #endif
                }
            }
            completion(.success(collection))
        }
    }
    
    class func createObject<T: Codable>(to url:String, key: String?, object: T, _ completion: @escaping (ResultRequest<T>) -> Void) {
        let collection = Firestore.firestore().collection(url)
        var db: DocumentReference!
        if let aKey = key {
            db = collection.document(aKey)
        }else{
            db = collection.document()
        }
        
        guard let docData = try? FirestoreEncoder().encode(object) else {
            completion(.failure(ServiceError.invalidData))
            return
        }
        db.setData(docData, merge: true) { error in
            if let error = error {
                #if DEBUG
                print("::: Error writing document: \(error)")
                #endif
                completion(.failure(ServiceError.errorCreatingObject))
            } else {
                completion(.success(nil))
            }
        }
    }
    
    class func deleteObject(to url:String, key: String?, _ completion: @escaping (ResultRequest<Any>) -> Void) {
        let db = Firestore.firestore().collection(url).document(url)
        db.delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
                completion(.failure(ServiceError.errorRemovingObject))
            } else {
                print("Document successfully removed!")
                completion(.success(nil))
            }
        }
    }
    
}

enum ServiceError: Error {
    case errorRemovingObject
    case errorCreatingObject
    case notFoundData
    case invalidData
    case invalidURL
    case invalidToken
    case genericError
    case mockupMissingError
    case notFoundEndpoint
    case customError(message:String)
}

extension ServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .errorRemovingObject:
            return NSLocalizedString("There was an error removing the object", comment: "Error")
        case .errorCreatingObject:
            return NSLocalizedString("There was an error creating the object", comment: "Error")
        case .notFoundData:
            return NSLocalizedString("There is no record in our system for that object", comment: "No Records")
        case .invalidData:
            return NSLocalizedString("The data doesn´t match the model expected", comment: "Invalid Data")
        case .invalidURL:
            return NSLocalizedString("The URL on the request is invalid", comment: "Invalid URL")
        case .invalidToken:
            return NSLocalizedString("Token has expired. Please login again", comment: "Invalid Token")
        case .genericError:
            return NSLocalizedString("There was an error on the response", comment: "Generic Error")
        case .mockupMissingError:
            return NSLocalizedString("There is no JSON file for that request", comment: "JSON FILE MISSING")
        case .notFoundEndpoint:
            return NSLocalizedString("There is no endpoint connection: 404", comment: "404 error")
        case .customError(let message):
            return NSLocalizedString(message, comment: "Error")
        }
    }
}

struct CommonError: Codable{
    var message: String? = ""
    var error: String? = ""
}

enum ResultRequest<T> {
    case success(T?)
    case failure(Error)
}
