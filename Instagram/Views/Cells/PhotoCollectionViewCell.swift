//
//  PhotoCollectionViewCell.swift
//  Instagram
//
//  Created by Amr Hossam on 23/07/2021.
//

import UIKit
import SDWebImage


class PhotoCollectionViewCell: UICollectionViewCell {

    static let identifier = "PhotoCollectionViewCell"
    
    
    private let imageView: UIImageView = {
       
        let imageView = UIImageView(image: UIImage(named: "testImage"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
//    
//    override func prepareForReuse() {
//        imageView.image = nil
//    }
//    
    func configure(with model: UserPost) {
        let url = model.thumbnailImage
        imageView.sd_setImage(with: url, completed: nil)
    }
    
    func configure(debug: String) {
        
    }
    
}
