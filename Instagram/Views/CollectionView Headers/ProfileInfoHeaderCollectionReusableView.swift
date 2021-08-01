//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by Amr Hossam on 23/07/2021.
//

import UIKit

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
