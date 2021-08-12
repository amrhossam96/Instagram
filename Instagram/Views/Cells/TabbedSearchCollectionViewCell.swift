//
//  TabbedSearchCollectionViewCell.swift
//  Instagram
//
//  Created by Amr Hossam on 12/08/2021.
//

import UIKit

class TabbedSearchCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TabbedSearchCollectionViewCell"
    
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("tap", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
