//
//  ViewController.swift
//  Instagram
//
//  Created by Amr Hossam on 15/07/2021.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    // Modeling a post inside the feed of the homeViewController
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}


class HomeViewController: UIViewController {
    
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    var storiesCollectionView: UICollectionView?
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
        tableView.register(IGLikesIndicatorTableViewCell.self,
                           forCellReuseIdentifier: IGLikesIndicatorTableViewCell.identifier)
        tableView.register(IGFeedPostCommentTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostCommentTableViewCell.identifier)
        return tableView
    }()
    
    let storiesPlaceholderView: UIView = {
        let view = UIView()
        return view
    }()
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableHeaderView = storiesPlaceholderView
        createMockModels()
        configureNavigationControllerIcons()
        configureStoriesCollectionView()
        guard let storiesCollectionView = storiesCollectionView else {
            return
        }
        storiesPlaceholderView.addSubview(storiesCollectionView)
        
    }
    
    private func configureStoriesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 80)
        storiesCollectionView = UICollectionView(frame: .zero,
                                                 collectionViewLayout: layout)
        storiesCollectionView?.showsHorizontalScrollIndicator = false
        storiesCollectionView?.delegate = self
        storiesCollectionView?.dataSource = self
        storiesCollectionView?.register(StoriesCollectionViewCell.self,
                                        forCellWithReuseIdentifier: StoriesCollectionViewCell.identifier)
        
    }
    
    
    private func configureNavigationControllerIcons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera,
                                                           target: self,
                                                           action: nil)

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "paperplane"),
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
        
        navigationItem.leftBarButtonItem?.tintColor = .label
        navigationItem.rightBarButtonItem?.tintColor = .label
        let origImage = UIImage(named: "mainlogo")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate).withTintColor(.label)

        navigationItem.titleView = UIImageView(image: tintedImage)

        navigationController?.navigationBar.tintColor = .label
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
        storiesPlaceholderView.frame = CGRect(x: 0, y: 0, width: view.width, height: 100)
        storiesCollectionView?.frame = storiesPlaceholderView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNonAuthenticated()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    private func handleNonAuthenticated() {
        // Check Auth status
        if Auth.auth().currentUser == nil {
            // Show login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x =  section
        let model : HomeFeedRenderViewModel
        if section == 0 {
            model = feedRenderModels[.zero]
        } else {
            let position = x%4 == 0 ? x/4 : (x-(x%4))/4
            model = feedRenderModels[position]
        }
        
        
        let subSection = x % 4
        if subSection == 0 {
            // header
            return 1
        } else if subSection == 1 {
            // post
            return 1
        } else if subSection == 2 {
            // actions
            return 1
        } else if subSection == 3 {
            // comments
            let commentModel = model.comments
            switch commentModel.renderType {
            case .comments(let comments): return comments.count > 4 ? 4 : comments.count
            case .header, .actions, .primaryContent: return 0
            }
        }
        return 0
    }
    
    private func createMockModels() {
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
        for _ in 0...5 {
            var cls = [commentLikes]()
            let cl = commentLikes(username: "Amr", commentIdentifier: "")
            cls.append(cl)
            var comments = [PostComment]()
            let comment = PostComment(identifier: "", username: "", text: "nice photo", createdDate: Date(), likes: cls)
            comments.append(comment)
            comments.append(comment)
            comments.append(comment)
            comments.append(comment)
            
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                    post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                    actions: PostRenderViewModel(renderType: .actions(provider: "")),
                                                    comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            // each object added to the feed renderModels will basically represent a post with 4 renderers for each section (header,post,actions,comments
            feedRenderModels.append(viewModel)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // x represents the index of a Full post
        // that technique was made to insure that each sub section gets rendered in its own row
        let x = indexPath.section
        let model : HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[.zero]
        } else {
            let position = x%4 == 0 ? x/4 : (x-(x%4))/4
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        if subSection == 0 {
            // header
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostHeaderTableViewCell
                cell.configure(with: user)
                cell.delegate = self
                return cell
            case .comments, .actions, .primaryContent: return UITableViewCell()
            }
        } else if subSection == 1 {
            // post
            switch model.post.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostTableViewCell
                cell.configure(with: post)
                return cell
            case .comments, .actions, .header: return UITableViewCell()
            }
            
        } else if subSection == 2 {
            // actions
            switch model.actions.renderType {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostActionsTableViewCell
                cell.delegate = self
                return cell
            case .comments, .header, .primaryContent: return UITableViewCell()
            }
            
        } else if subSection == 3 {
            // comments
            switch model.comments.renderType {
            case .comments(let comments):
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGLikesIndicatorTableViewCell.identifier,
                                                                                      for: indexPath) as! IGLikesIndicatorTableViewCell
                    return cell
                }
                else if indexPath.row == 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier,
                                                                                      for: indexPath) as! IGFeedPostGeneralTableViewCell
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostCommentTableViewCell.identifier,
                                                                                      for: indexPath) as! IGFeedPostCommentTableViewCell
                    return cell
                }
            case .header, .actions, .primaryContent: return UITableViewCell()
            }
            
            
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let subSection = indexPath.section % 4
        if subSection == 0 {
            return 70
        } else if subSection == 1 {
            return tableView.width
        }
        else if subSection == 2 {
            return 45
        }
        else if subSection == 3 {
            return 30
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
}


extension HomeViewController: IGFeedPostHeaderTableViewCellDelegate {
    
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post Options", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Report the post", style: .destructive, handler: { [weak self] _ in
            self?.reportPost()
            
        }))
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    
    private func reportPost() {
        
    }
    
    
}


extension HomeViewController: IGFeedPostActionsTableViewCellDelegate {
    func didTapBookmarkButton() {
        print("bookmark")
    }
    
    
    func didTapLikeButton() {
        print("Like")
    }
    
    func didTapCommentButton() {
        print("Comment")
    }
    
    func didTapSendButton() {
        print("Send")
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoriesCollectionViewCell.identifier,
                                                      for: indexPath) as! StoriesCollectionViewCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
