//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Amr Hossam on 15/07/2021.
//

import UIKit

struct EditProfileFormModel {
    let label:String
    let placeHolder: String
    var value: String?
}





final class EditProfileViewController: UIViewController, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()
    
    
    private var models = [[EditProfileFormModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        tableView.allowsSelection = false
        tableView.tableHeaderView = createTableHeaderView()
        view.backgroundColor = .systemBackground

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapCancel))
        
        view.addSubview(tableView)
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        
        return "Private information"
    }
    
    private func configureModels() {
        // name username website bio
        let sectionOneLabels = ["Name","Username","Website","Bio"]
        var sectionOne = [EditProfileFormModel]()
        for label in sectionOneLabels {
            let model = EditProfileFormModel(label: label, placeHolder: "Enter \(label)", value: nil)
            sectionOne.append(model)
        }
        models.append(sectionOne)
        // email phone gender
        
        let sectionTwoLabels = ["Email","Phone","Gender"]
        var sectionTwo = [EditProfileFormModel]()
        for label in sectionTwoLabels {
            let model = EditProfileFormModel(label: label, placeHolder: "Enter \(label)", value: nil)
            sectionTwo.append(model)
        }
        models.append(sectionTwo)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc private func didTapSave() {
        // save to database
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
    
    private func createTableHeaderView() -> UIView{
        let header = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.width,
                                          height: view.height / 4).integral)
        let size = header.height / 1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width - size) / 2,
                                                        y: (header.height - size) / 2,
                                                        width: size,
                                                        height: size))
        
        header.addSubview((profilePhotoButton))
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size / 2.0
        
        profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.fill"), for: .normal)

        profilePhotoButton.tintColor = .label
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return header
    }
    
    @objc func didTapProfilePhotoButton() {
        
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
        actionSheet.addAction(UIAlertAction(title: "Cancel",style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
    
}


extension EditProfileViewController: FormTableViewCellDelegate {

    
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
        print(updatedModel.label)
        print(updatedModel.value ?? "nil")
    }
}
