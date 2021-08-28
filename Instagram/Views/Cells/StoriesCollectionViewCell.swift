//
//  StoriesCollectionViewCell.swift
//  Instagram
//
//  Created by Amr Hossam on 19/08/2021.
//

import UIKit




class StoriesCollectionViewCell: UICollectionViewCell {
    static let identifier = "StoriesCollectionViewCell"
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor(red: 0.8863, green: 0, blue: 0.4, alpha: 1.0).cgColor
        imageView.image = #imageLiteral(resourceName: "testImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        addSubview(cellImageView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellImageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        cellImageView.layer.cornerRadius = cellImageView.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
