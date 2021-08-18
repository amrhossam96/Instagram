//
//  IGLikesIndicatorTableViewCell.swift
//  Instagram
//
//  Created by Amr Hossam on 18/08/2021.
//

import UIKit

class IGLikesIndicatorTableViewCell: UITableViewCell {

    static let identifier = "IGLikesIndicatorTableViewCell"
   
    let likesIindicator: UILabel = {
        let label = UILabel()
        label.text = "12 Likes"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(likesIindicator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    public func configure() {
        // configure the cell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        likesIindicator.frame = CGRect(x: 15, y: 0, width: 120, height: contentView.height)
    }

}
