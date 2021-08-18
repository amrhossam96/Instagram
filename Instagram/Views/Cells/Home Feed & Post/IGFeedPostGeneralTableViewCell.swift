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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    let postOwnerCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Caption goes herer"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(postOwnerUsernameLabel)
        addSubview(postOwnerCaptionLabel)
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    public func configure() {
        // configure the cell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postOwnerUsernameLabel.frame = CGRect(x: 15, y: 0, width: 120, height: contentView.height)

        postOwnerCaptionLabel.leftAnchor.constraint(equalTo: postOwnerUsernameLabel.rightAnchor,constant: 25).isActive = true
        postOwnerCaptionLabel.topAnchor.constraint(equalTo: postOwnerUsernameLabel.topAnchor, constant: 5).isActive = true
    }
}
