//
//  PostViewController.swift
//  Instagram
//
//  Created by Amr Hossam on 15/07/2021.
//

import UIKit

/*
 Section
 - Header Model
 Section
 - Post cell model
 Section
 - Action Button cell model
 Section
 - n Numbers for general models for comments
 
 */

// we use enums instead of creating a whole new type. it gives us to create types without a real structure

enum PostRenderType {
    case header(provider: User)
    case primaryContent(provider: UserPost)
    case actions(provider: String)
    case comments(comments: [PostComment])
}

struct PostRenderViewModel {
    let renderType: PostRenderType
    
}



class PostViewController: UIViewController {
    
    private let model: UserPost?
    private var renderedModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        
        tableView.register(IGFeedPostHeaderTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        
        tableView.register(IGFeedPostActionsTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        
        tableView.register(IGFeedPostGeneralTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    
    init(model: UserPost?) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        configureModels()
        
    }
    
    private func configureModels() {
        guard let userPostModel = model else {
            return
        }
        // This is the renderer that will render the cells of the feed (Post)
        renderedModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        renderedModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        renderedModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        
        var cls = [commentLikes]()
        let cl = commentLikes(username: "Amr", commentIdentifier: "")
        cls.append(cl)
        var comments = [PostComment]()
        let comment = PostComment(identifier: "", username: "", text: "nice photo", createdDate: Date(), likes: cls)
        comments.append(comment)
        comments.append(comment)
        comments.append(comment)
        comments.append(comment)
        comments.append(comment)
        comments.append(comment)
        comments.append(comment)
        comments.append(comment)
        renderedModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderedModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch renderedModels[section].renderType {
        case .actions(provider: _): return 1
        case .comments(let comments): return comments.count > 4 ? 4:comments.count
        case .primaryContent(provider: _): return 1
        case .header(provider: _): return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = renderedModels[indexPath.section]
        switch model.renderType {
        case .actions(let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier,
                                                     for: indexPath) as! IGFeedPostActionsTableViewCell
            return cell
            
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier,
                                                     for: indexPath) as! IGFeedPostGeneralTableViewCell
            return cell
            
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier,
                                                     for: indexPath) as! IGFeedPostTableViewCell
            return cell
            
        case .header(let users):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,
                                                     for: indexPath) as! IGFeedPostHeaderTableViewCell
            return cell
        
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = renderedModels[indexPath.section]
        switch model.renderType {
        case .actions(_):
            return 60
            
        case .comments(_):
            return 50
            
        case .primaryContent(_):
            return tableView.width
            
        case .header(_):
            return 70
        
        }
        
    }
    
}
