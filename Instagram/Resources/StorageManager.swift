//
//  StorageManager.swift
//  Instagram
//
//  Created by Amr Hossam on 15/07/2021.
//

import FirebaseStorage

public class StorageManager {
    
    static let shared = StorageManager()
    
    
    
    public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    
    private let bucket = Storage.storage().reference()
    
    // MARK: - Public
    
    
    public func uploadUserPost(model: UserPost, completion: (Result<URL,Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL,IGStorageManagerError>)->Void){
        bucket.child(reference).downloadURL {  url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            
            completion(.success(url))
        }
    }
}


public enum UserPostType {
    case photo, video
}


public struct UserPost {
    
    let postType: UserPostType
}
