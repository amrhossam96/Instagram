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
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    
    func configure(with model: ButtonRenderer) {
        switch model.type {
        case ButtonType.people:
            button.setTitle(ButtonType.people.rawValue, for: .normal)
        case ButtonType.tag:
            button.setTitle(ButtonType.tag.rawValue, for: .normal)
        case ButtonType.location:
            button.setTitle(ButtonType.location.rawValue, for: .normal)
        }
    }
    
    
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
