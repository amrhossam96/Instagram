//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by Amr Hossam on 23/07/2021.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)

    
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        imageView.sd_setImage(with: URL(string: "https://scontent.fcai19-2.fna.fbcdn.net/v/t39.30808-6/216948580_3014008168830001_3505515814490728137_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=P-c6ef6jsmYAX_xh4Tx&_nc_ht=scontent.fcai19-2.fna&oh=89c65d44a03f1520e7a028ce9b8abb3a&oe=612DCA11"), completed: nil)
        return imageView
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Following", for: .normal)
        return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Followers", for: .normal)
        return button
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Edit your profile", for: .normal)
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Amr Hossam"
        label.textColor = .label
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // line wrap
        label.textColor = .label
        label.text = "This is the first Account!"
        return label
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubviews()
        addButtonActions()
        
    }
    
    
    private func addSubviews() {
        addSubview(profilePhotoImageView)
        addSubview(followingButton)
        addSubview(followersButton)
        addSubview(postsButton)
        addSubview(nameLabel)
        addSubview(editProfileButton)
        addSubview(bioLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width / 4.0
        profilePhotoImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: profilePhotoSize,
            height: profilePhotoSize).integral
        
        let buttonHeight = profilePhotoSize / 2
        let countButtonWidth = (width-profilePhotoSize-10) / 3
        
        postsButton.frame = CGRect(
            x: profilePhotoImageView.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight).integral
        
        followersButton.frame = CGRect(
            x: postsButton.right,
            y: 5,
            width: profilePhotoSize,
            height: buttonHeight).integral
        
        followingButton.frame = CGRect(
            x: followersButton.right,
            y: 5,
            width: profilePhotoSize,
            height: buttonHeight).integral
        
        editProfileButton.frame = CGRect(
            x: profilePhotoImageView.right,
            y: 5 + buttonHeight,
            width: countButtonWidth*3+4,
            height: buttonHeight).integral
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize / 2
        
        
        nameLabel.frame = CGRect(
            x: 5,
            y: 5 + profilePhotoImageView.bottom,
            width: width - 10,
            height: 50).integral
        
        
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(
            x: 5,
            y: 5 + nameLabel.bottom,
            width: width - 10,
            height: bioLabelSize.height).integral
    }
    
    
    
    private func addButtonActions(){
        followersButton.addTarget(self,
                                  action: #selector(didTapFollowerButton),
                                  for: .touchUpInside)
        
        followingButton.addTarget(self,
                                  action: #selector(didTapFollowingButton),
                                  for: .touchUpInside)
        
        postsButton.addTarget(self,
                                  action: #selector(didTapPostsButton),
                                  for: .touchUpInside)
        
        editProfileButton.addTarget(self,
                                  action: #selector(didTapEditProfileButton),
                                  for: .touchUpInside)
    }
    
    
    @objc func didTapFollowerButton() {
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    
    @objc func didTapFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    
    @objc func didTapPostsButton() {
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    
    @objc func didTapEditProfileButton() {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
}
