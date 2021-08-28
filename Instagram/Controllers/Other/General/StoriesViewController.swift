//
//  StoriesViewController.swift
//  Instagram
//
//  Created by Amr Hossam on 28/08/2021.
//

import UIKit

class StoriesViewController: UIViewController {

    var model: UserPost?{
        didSet {
            guard let model = model else {return}
            imageView.sd_setImage(with: model.thumbnailImage, completed: nil)
        }
    }
    
    
    
 
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
    }
    
    
    override func viewDidLayoutSubviews() {
        imageView.frame = view.bounds
    }
    
    
    

    

}
