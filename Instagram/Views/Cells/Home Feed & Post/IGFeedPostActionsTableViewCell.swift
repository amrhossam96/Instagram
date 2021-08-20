//
//  IGFeedPostActionsTableViewCell.swift
//  Instagram
//
//  Created by Amr Hossam on 19/07/2021.
//

import UIKit


protocol IGFeedPostActionsTableViewCellDelegate: AnyObject {
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapSendButton()
    func didTapBookmarkButton()
}

class IGFeedPostActionsTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostActionsTableViewCell"
   
    weak var delegate: IGFeedPostActionsTableViewCellDelegate?
    
    
    private let likeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .light)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .light)
        let image = UIImage(systemName: "message", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    
    private let sendButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .light)
        let image = UIImage(systemName: "paperplane", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    
    private let bookmarkButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .light)
        let image = UIImage(systemName: "bookmark", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(sendButton)
        contentView.addSubview(bookmarkButton)
        
        likeButton.addTarget(self,
                             action: #selector(didTapLikeButton),
                             for: .touchUpInside)
        
        commentButton.addTarget(self,
                                action: #selector(didTapCommentButton),
                                for: .touchUpInside)
        
        sendButton.addTarget(self,
                             action: #selector(didTapSendButton),
                             for: .touchUpInside)
        bookmarkButton.addTarget(self,
                                 action: #selector(didTapBookmarkButton),
                                 for: .touchUpInside)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapBookmarkButton(){
        delegate?.didTapBookmarkButton()
    }
    @objc private func didTapLikeButton(){
        delegate?.didTapLikeButton()
    }
    
    @objc private func didTapCommentButton(){
        delegate?.didTapCommentButton()
    }
    @objc private func didTapSendButton(){
        delegate?.didTapSendButton()
    }
   
    
    public func configure(with post: UserPost) {
        // configure the cell
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonSize = contentView.height - 10
        let buttons = [likeButton, commentButton, sendButton]
        
        for x in 0..<buttons.count {
            let button = buttons[x]
            button.frame = CGRect(x: (CGFloat(x)*buttonSize) + (10*CGFloat(x+1)), y: 5, width: buttonSize, height: buttonSize)
        }
        bookmarkButton.frame = CGRect(x: contentView.width-50, y: 5, width: buttonSize, height: buttonSize)
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
