//
//  NotificationsViewController.swift
//  Instagram
//
//  Created by Amr Hossam on 15/07/2021.
//

import UIKit

enum UserNotificationType {
    case follow(state: FollowState)
    case like(post: UserPost)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

final class NotificationsViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationLikeEventTableViewCell.self,
                           forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.register(NotificationFollowEventTableViewCell.self,
                           forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        
        return tableView
    }()
    
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
        
    }()
    
    private lazy var noNotificationsView: UIView = NoNotificationsView()
    private var models = [UserNotification]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Notifications"
        tableView.delegate = self
        tableView.dataSource = self
        //        view.addSubview(tableView)
        view.addSubview(spinner)
        view.addSubview(tableView)
        //        spinner.startAnimating()
        fetchNotifications()
        
    }
    
    private func fetchNotifications() {
        for x in 0...100 {
            
            let user = User(username: "@Amr",
                            name: (first: "Amr", last: "Hossam"),
                            profilePhoto: URL(string: "www.google.com)")!,
                            birthDate: Date(),
                            gender: .male,
                            bio: "",
                            counts: UserCount(followers: 1,
                                              following: 1,
                                              posts: 1),
                            joinedDate: Date())
            
            let post = UserPost(identifier: "",
                                postType: .photo,
                                thumbnailImage: URL(string: "www.google.com)")!,
                                postUrl: URL(string: "www.google.com)")!,
                                caption: nil,
                                likeCount: [],
                                comments: [],
                                createdDate: Date(),
                                taggedUsers: [user,user,user],
                                owner: user)
            
            let model = UserNotification(type: x % 2 == 0 ? .like(post: post):.follow(state: .not_following),
                                             text: "Hello world",
                                             user: user)
            models.append(model)
        }
    }
    
    private func addNoNotifications() {
        tableView.isHidden = true
        view.addSubview(tableView)
        
        noNotificationsView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.width/2,
            height: view.width/4)
        noNotificationsView.center = view.center
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(
            x: 0,
            y: 0,
            width: 100,
            height: 100)
        spinner.center = view.center
    }
    
    
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        NotificationLikeEventTableViewCell
        let model = models[indexPath.row]
        switch model.type {
        case .like:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            cell.delegate = self
            cell.configure(with: model)
            return cell
            
        case .follow:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
            
            cell.delegate = self
//            cell.configure(with: model)
            return cell
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}


extension NotificationsViewController: NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
        
        switch model.type {
        case .like(let post):
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            
            navigationController?.pushViewController(vc, animated: true)
        case .follow(state: _):
            fatalError("Dev Error: Should never get called")
        
        }
        
        
    }
    
    
}

extension NotificationsViewController: NotificationFollowEventTableViewCellDelegate {
    func didTapFollowUnfollowButton(model: UserNotification) {
        print("tapped follow")
    }
    
    
}
