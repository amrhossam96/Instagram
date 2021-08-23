//
//  PostEditorViewController.swift
//  Instagram
//
//  Created by Amr Hossam on 15/07/2021.
//

import UIKit
import iOSPhotoEditor

class PostEditorViewController: UIViewController {

    var filtersCollectionView: UICollectionView?
    let context = CIContext()
    var originalImage: UIImage?
    var originalCIImage: CIImage?

    var filterNames: [String: String] = [
        "Sepia":"CISepiaTone",
        "70's":"CIPhotoEffectTransfer",
        "Vintage":"CIPhotoEffectProcess",
        "Noir":"CIPhotoEffectNoir",
        "Instant":"CIPhotoEffectInstant",
        "Fade":"CIPhotoEffectFade",
        "Chrome":"CIPhotoEffectChrome"
    ]
    
    var filters = [FilterModel]()
    
    
    let shareButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        let image = UIImage(systemName: "paperplane", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let cancelEditButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        let image = UIImage(systemName: "xmark", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    @objc private func didTapCancelEditButton() {
        context.clearCaches()
        dismiss(animated: true, completion: nil)
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private func configureFiltersCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 90, height: 120)
        filtersCollectionView = UICollectionView(frame: .zero,
                                                 collectionViewLayout: layout)
        filtersCollectionView?.register(FiltersCollectionViewCell.self,
                                        forCellWithReuseIdentifier: FiltersCollectionViewCell.identifier)
        filtersCollectionView?.dataSource = self
        filtersCollectionView?.delegate = self
        filtersCollectionView?.showsHorizontalScrollIndicator = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(cancelEditButton)
        view.addSubview(shareButton)
        configureFiltersCollectionView()
        guard let filtersCollectionView = filtersCollectionView else {return}
        view.addSubview(filtersCollectionView)
        cancelEditButton.addTarget(self,
                                   action: #selector(didTapCancelEditButton),
                                   for: .touchUpInside)
        guard let originalImage = originalImage else {return}
        originalCIImage = CIImage(image: originalImage)
        imageView.image = UIImage(ciImage: originalCIImage!)
        shareButton.addTarget(self,
                              action: #selector(didTapShareButton),
                              for: .touchUpInside)
    }
    
    @objc private func didTapShareButton() {
        let vc = PublishPostViewController()
        vc.image = imageView.image
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        imageView.frame = view.bounds
        cancelEditButton.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: 90, height: 90)
        filtersCollectionView?.frame = CGRect(x: 0, y: view.bottom-200, width: view.width, height: 120)
        shareButton.frame =  CGRect(x: view.width - 90, y: view.safeAreaInsets.top, width: 90, height: 90)
    }
}


extension PostEditorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterNames.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageView.image = filters[indexPath.row].thumbnailImage
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FiltersCollectionViewCell.identifier,
                                                      for: indexPath) as! FiltersCollectionViewCell

        if let image = originalCIImage {
            
            let results: CIImage?
            let filterName = Array(filterNames.keys)[indexPath.row]
            let editedImage: UIImage?
            switch filterName {
            case "Sepia":
                results = applyFilter(image, filterName: "CISepiaTone", intensity: 0.9)
                editedImage = UIImage(ciImage: results!)
                let model = FilterModel(name: filterName, thumbnailImage: editedImage!)
                filters.append(model)
                cell.configure(with: model)
                
            case "70's":
                results = applyFilter(image, filterName: "CIPhotoEffectTransfer")
                editedImage = UIImage(ciImage: results!)
                let model = FilterModel(name: filterName, thumbnailImage: editedImage!)
                filters.append(model)
                cell.configure(with: model)
                
            case "Vintage":
                results = applyFilter(image, filterName: "CIPhotoEffectProcess")
                editedImage = UIImage(ciImage: results!)
                let model = FilterModel(name: filterName, thumbnailImage: editedImage!)
                filters.append(model)
                cell.configure(with: model)
                
            case "Noir":
                results = applyFilter(image, filterName: "CIPhotoEffectNoir")
                editedImage = UIImage(ciImage: results!)
                let model = FilterModel(name: filterName, thumbnailImage: editedImage!)
                filters.append(model)
                cell.configure(with: model)
                
            case "Instant":
                results = applyFilter(image, filterName: "CIPhotoEffectInstant")
                editedImage = UIImage(ciImage: results!)
                let model = FilterModel(name: filterName, thumbnailImage: editedImage!)
                filters.append(model)
                cell.configure(with: model)
                
            case "Fade":
                results = applyFilter(image, filterName: "CIPhotoEffectFade")
                editedImage = UIImage(ciImage: results!)
                let model = FilterModel(name: filterName, thumbnailImage: editedImage!)
                filters.append(model)
                cell.configure(with: model)
                
            case "Chrome":
                results = applyFilter(image, filterName: "CIPhotoEffectChrome")
                editedImage = UIImage(ciImage: results!)
                let model = FilterModel(name: filterName, thumbnailImage: editedImage!)
                filters.append(model)
                cell.configure(with: model)

            default: fatalError("Dev Error")
            }
        }
        
        return cell
    }
    
    private func applyFilter(_ input: CIImage,filterName: String, intensity: Double) -> CIImage?
    {
        let filter = CIFilter(name: filterName)
        filter?.setValue(input, forKey: kCIInputImageKey)
        filter?.setValue(intensity, forKey: kCIInputIntensityKey)
        return filter?.outputImage
    }
    
    private func applyFilter(_ input: CIImage, filterName: String) -> CIImage?
    {
        let filter = CIFilter(name:filterName)
        filter?.setValue(input, forKey: kCIInputImageKey)
        return filter?.outputImage
    }
    
}

