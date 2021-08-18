//
//  MainTabBarViewController.swift
//  Instagram
//
//  Created by Amr Hossam on 18/08/2021.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: ExploreViewController())
        let vc3 = UINavigationController(rootViewController: CameraViewController())
        let vc4 = UINavigationController(rootViewController: NotificationsViewController())
        let vc5 = UINavigationController(rootViewController: ProfileViewController())
        
        setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)
        
        let images = ["house","grid","plus","heart","person"]
        guard let items = tabBar.items else {
            return
        }
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
        tabBar.tintColor = .label
    }
    

    

}
