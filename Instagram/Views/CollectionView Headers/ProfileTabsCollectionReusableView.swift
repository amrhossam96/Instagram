//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by Amr Hossam on 23/07/2021.
//

import UIKit


protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButtonTab()
    func didTapTaggedButtonTab()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    struct Constants {
        static let padding: CGFloat = 8
    }
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(taggedButton)
        addSubview(gridButton)
        gridButton.addTarget(self,
                             action: #selector(didTapGridButton),
                             for: .touchUpInside)
        
        taggedButton.addTarget(self,
                               action: #selector(didTapTaggedButton),
                               for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height - (Constants.padding * 2)
        let gridButtonX = ((width / 2) - size)/2
        gridButton.frame = CGRect(
            x: gridButtonX,
            y: Constants.padding,
            width: size,
            height: size)
        
        taggedButton.frame = CGRect(
            x: gridButtonX + (width/2),
            y: Constants.padding,
            width: size,
            height: size)
        
    }
    
    
    @objc private func didTapGridButton() {
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        delegate?.didTapGridButtonTab()
    }
    
    @objc private func didTapTaggedButton() {
        taggedButton.tintColor = .systemBlue
        gridButton.tintColor = .lightGray
        delegate?.didTapTaggedButtonTab()
    }
    
}
