//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Amr Hossam on 15/07/2021.
//

import UIKit
import SafariServices

struct SettingCellModel {
    let title: String
    let handler: () -> Void
}

final class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    private func configureModels() {
        
        data.append([SettingCellModel(title: "Edit Profile") { [weak self] in
            
            self?.didTapEditProfile()
            
        },
        SettingCellModel(title: "Invite Friends"){ [weak self] in
            self?.didTapInviteFriends()
        },
        SettingCellModel(title: "Save Original Posts"){ [weak self] in
            self?.didTapSaveOriginalPosts()
        }])
        
        data.append([SettingCellModel(title: "Terms of service") { [weak self] in
            self?.openUrl(type: .terms)
        },
        SettingCellModel(title: "Privacy Policy") { [weak self] in
            self?.openUrl(type: .privacy)
        },
        SettingCellModel(title: "Help and Feedback"){ [weak self] in
            self?.openUrl(type: .help)
        }])
        
        
        data.append([SettingCellModel(title: "Logout") { [weak self] in
            self?.didTapLogout()
        }])
    }
    
    private func didTapLogout() {
        let actionSheet = UIAlertController(title: "Logout",
                                            message: "Are you sure you want to logout ?",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Logout",style: .destructive,handler: { _ in
            AuthManager.shared.logOut { success in
                DispatchQueue.main.async {
                    if success {
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true) {
                            self.navigationController?.popToRootViewController(animated: true)
                            self.tabBarController?.selectedIndex = 0
                        }
                    } else {
                        fatalError("Could not log out user")
                    }
                }
                
            }
        }))
        
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet,animated: true)
        
    }
    
    
    
    public enum SettingsURLType {
        case terms, privacy, help
    }
    
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        present(navVc, animated: true)
    }
    
    private func didTapInviteFriends() {
        // show share sheet
    }
    
    private func didTapSaveOriginalPosts() {
        
    }
    
    private func openUrl(type: SettingsURLType) {
        let urlString: String
        switch type {
        case .terms: urlString = "https://www.instagram.com/about/legal/terms/before-january-19-2013/"
        case .help: urlString = "https://help.instagram.com"
        case .privacy: urlString = "https://help.instagram.com/519522125107875"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    
    
}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
    
}
