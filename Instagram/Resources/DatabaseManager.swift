//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Amr Hossam on 15/07/2021.
//

import FirebaseDatabase
import FirebaseAuth

public class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    
    
    //MARK:- Public
    /// Check if username and email is available
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Callback function triggered when database respond
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    public func addUserPost(post: UserPost, completion: @escaping (Bool) -> Void) {
        
        database.child("posts").child((Auth.auth().currentUser?.email?.safeDatabaseKey())!)
            .child(post.identifier)
            .setValue([
                "owner":post.owner.username,
                "caption":"\(post.caption!)",
                "identifier":post.identifier,
                "comments":post.comments,
                "createdDate":post.createdDate.description,
                "likeCount":post.likeCount.description,
                "postType":post.postType.rawValue,
                "postURL":post.postUrl.absoluteString,
                "postThumbnail":post.thumbnailImage.absoluteString,
                "taggedUsers":post.taggedUsers.map({ user in
                    return user.username
                }),
            ]){ error, _ in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
    }
    
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
    }
    
    public func updateUserInfo(name: String, username: String, website: String, bio: String, email: String, phone: String, gender: String, completion: @escaping (Bool)-> Void) {
        guard let emailAddress = Auth.auth().currentUser?.email else {return}
        database.child(emailAddress.safeDatabaseKey()).setValue(["name":name,
                                                          "username": username,
                                                          "website":website,
                                                          "bio":bio,
                                                          "email":email.safeDatabaseKey(),
                                                          "phone":phone,
                                                          "gender":gender]){ error, _ in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
        
    }
    
    public func getUserInfo(email: String, completion: @escaping (Bool, [String: String]) -> Void) {
        database.child(email.safeDatabaseKey()).getData { error, snapshot in
            guard let data = snapshot.value else {return}
            completion(true, data as! [String:String])
        }
    }
    
    
    
}
