//
//  StorageManager.swift
//  Instagram
//
//  Created by Amr Hossam on 15/07/2021.
//

import FirebaseStorage
import UIKit

public class StorageManager {
    
    static let shared = StorageManager()
    
    
    
    public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    
    private let bucket = Storage.storage().reference()
    
    // MARK: - Public
    
    public func uploadUserImage(image: UIImage, completion: @escaping (Bool, URL?) -> Void) {
        let name = UUID.init().uuidString
        let uploadRef = bucket.child("images").child("\(name).jpg")
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        let uploadMetaData = StorageMetadata.init()
        uploadMetaData.contentType = "image/jpeg"
        let taskRef = uploadRef.putData(imageData, metadata: uploadMetaData) { downloadMetaData, error in
            if error != nil {
                print("Error: upload")
                completion(false, nil)
            }
            uploadRef.downloadURL { url, error in
                guard let url = url else {return}
                completion(true, url)
            }
            
            print("upload succeed. \(String(describing: downloadMetaData))")
        }
        taskRef.observe(.progress) { snapShot in
            guard let currentPr = snapShot.progress?.fractionCompleted else {
                return
            }
            
            print(currentPr)
            
        }
        
            
        
        
    }
    
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
