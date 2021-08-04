//
//  UserFollowTableViewCell.swift
//  Instagram
//
//  Created by Amr Hossam on 02/08/2021.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserRelationShip)
    
}

enum FollowState {
    case following, not_following
}

public struct UserRelationShip {
    let username: String
    let name: String
    let type: FollowState
}


class UserFollowTableViewCell: UITableViewCell {
    
    static let identifier = "UserFollowTableViewCell"
    public weak var delegate: UserFollowTableViewCellDelegate?
    
    private var model: UserRelationShip?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "Joe"
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "@joe"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(followButton)
        contentView.addSubview(profileImageView)
        followButton.addTarget(self,
                               action: #selector(didTapFollowButton),
                               for: .touchUpInside)
        selectionStyle = .none
        
    }
    
    public func configure(with model: UserRelationShip) {
        self.model = model
        nameLabel.text = model.name
        userNameLabel.text = model.username
        switch model.type {
        case .following:
            // show unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.setTitleColor(.label, for: .normal)
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            // show follow button
            followButton.setTitle("Follow", for: .normal)
            followButton.backgroundColor = .link
            followButton.setTitleColor(.white, for: .normal)
            followButton.layer.borderWidth = 0
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        userNameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = .zero
        followButton.backgroundColor = nil
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        followButton.layer.cornerRadius = 5
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height-6,
                                        height: contentView.height-6)
        
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
        let buttonWidth = contentView.width > 500 ? 220 : contentView.width / 3
        
        followButton.frame = CGRect(x: contentView.width-5-buttonWidth,
                                    y: (contentView.height-40)/2,
                                    width: buttonWidth,
                                    height: 40)
        
        let labelHeight = contentView.height / 2
        nameLabel.frame = CGRect(x: profileImageView.right + 5,
                                 y: 0,
                                 width: contentView.width-8-profileImageView.width - buttonWidth,
                                 height: labelHeight)
        
        userNameLabel.frame = CGRect(x: profileImageView.right + 5,
                                     y: nameLabel.bottom,
                                     width: contentView.width-8-profileImageView.width - buttonWidth,
                                     height: labelHeight-20)
        
    }
    @objc private func didTapFollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
}
