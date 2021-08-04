//
//  NotificationLikeEventTableViewCell.swift
//  Instagram
//
//  Created by Amr Hossam on 03/08/2021.
//

import UIKit
import SDWebImage

protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationLikeEventTableViewCell"
    
    weak var delegate: NotificationLikeEventTableViewCellDelegate?
    private var model: UserNotification?
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "testImage")
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "@Sarah Hany Liked your photo"
        label.numberOfLines = 0 // wrap
        return label
    }()
    
    
    let postButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "testImage"), for: .normal)
        return button
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        postButton.addTarget(self,
                             action: #selector(didTapPostButton),
                             for: .touchUpInside)
        selectionStyle = .none
        
    }
    
    @objc private func didTapPostButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapRelatedPostButton(model: model)
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(let post):
            let thumbnail = post.thumbnailImage
           
            guard !thumbnail.absoluteString.contains("google.com") else {
                return
            }
            
            postButton.sd_setBackgroundImage(with: thumbnail,
                                             for: .normal,
                                             completed: nil)
        case .follow:
            break
        }
        
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto,
                                     completed: nil)
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setBackgroundImage(nil, for: .normal)
        label.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height-6,
                                        height: contentView.height-6)
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = contentView.height/2
        let size = contentView.height-4
        postButton.frame = CGRect(x: contentView.width-5-size,
                                  y: 2,
                                  width: size,
                                  height: size)
        label.frame = CGRect(x: profileImageView.right+5,
                             y: 0,
                             width: contentView.width-size-profileImageView.width-16,
                             height: contentView.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
