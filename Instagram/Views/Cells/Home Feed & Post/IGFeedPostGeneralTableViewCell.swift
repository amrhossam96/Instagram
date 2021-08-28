//
//  IGFeedPostGeneralTableViewCell.swift
//  Instagram
//
//  Created by Amr Hossam on 19/07/2021.
//

import UIKit

class IGFeedPostGeneralTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostGeneralTableViewCell"
   
    let postOwnerUsernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@amrhossam"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let postOwnerCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Caption goes here"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(postOwnerUsernameLabel)
        addSubview(postOwnerCaptionLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    public func configure() {
        // configure the cell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postOwnerUsernameLabel.frame = CGRect(x: 15, y: 0, width: 120, height: height)
        postOwnerCaptionLabel.frame = CGRect(x: postOwnerUsernameLabel.right+10, y: 0, width: width - (postOwnerUsernameLabel.right + 10), height: contentView.height)
    }
}
