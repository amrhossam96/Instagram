//
//  PublishPostViewController.swift
//  Instagram
//
//  Created by Amr Hossam on 15/07/2021.
//

import UIKit

class PublishPostViewController: UIViewController {

    
    let publishButton: UIButton = {
       
        let button = UIButton()
        button.setTitle("Publish", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
        
    }()
    var image: UIImage?
    let captionTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Write a caption"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 1.0
        field.sizeToFit()
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    let aboutToPublishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(aboutToPublishImageView)
        view.addSubview(captionTextField)
        view.backgroundColor = .systemBackground
        view.addSubview(publishButton)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aboutToPublishImageView.frame = CGRect(x: 0, y: 200, width: view.width, height: view.width)
        aboutToPublishImageView.image = image
        captionTextField.frame = CGRect(x: 10, y: aboutToPublishImageView.bottom + 10, width: view.width - 20, height: 60)
        publishButton.frame = CGRect(x: view.width - 100, y: view.safeAreaInsets.top + 20, width: 90, height: 40)
    }
    


}
