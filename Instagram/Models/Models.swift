//
//  Models.swift
//  Instagram
//
//  Created by Amr Hossam on 01/08/2021.
//

import Foundation



public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}

public enum Gender {
    case male, female, other
    
}

struct User {
    let username: String
    let name: (first: String, last: String)
    let profilePhoto: URL
    let birthDate: Date
    let gender: Gender
    let bio: String
    let counts: UserCount
    let joinedDate: Date
    
    
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

public struct UserPost {
    
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postUrl: URL
    let caption: String?
    let likeCount: [PostLikes]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [User]
    let owner: User
}

struct PostLikes {
    let username: String
    let postIdentifier: String
    
}

struct commentLikes {
    let username: String
    let commentIdentifier: String
    
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [commentLikes]
}
