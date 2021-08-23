//
//  FiltersCollectionViewCell.swift
//  Instagram
//
//  Created by Amr Hossam on 23/08/2021.
//

import UIKit



class FiltersCollectionViewCell: UICollectionViewCell {
    static let identifier = "FiltersCollectionViewCell"
    
    let filterImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let filterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(filterImageView)
        addSubview(filterLabel)
    }
    
    
    func configure(with model: FilterModel) {
        filterImageView.image = model.thumbnailImage
        filterLabel.text = model.name
    }
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        filterImageView.frame = CGRect(x: 0, y: 0, width: width, height: 90)
        filterLabel.frame = CGRect(x: 0, y: filterImageView.bottom, width: width, height: 30)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
