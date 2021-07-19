//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Amr Hossam on 15/07/2021.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapCancel))
        
    didTapChangeProfilePicture()
    }
    
    
    @objc private func didTapSave() {
        
    }
    
    
    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
    
    
    
    @objc private func didTapChangeProfilePicture() {
        
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "Change profile picture",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Take photo",style: .default) { _ in
            
        })
        
        actionSheet.addAction(UIAlertAction(title: "Choose from library",style: .default) { _ in
            
        })
        
        
        popoverPresentationController?.sourceView = view
        popoverPresentationController?.sourceRect = view.bounds
        actionSheet.addAction(UIAlertAction(title: "Cancle",style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
    
}
