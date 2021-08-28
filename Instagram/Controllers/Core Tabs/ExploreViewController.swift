//
//  ExploreViewController.swift
//  Instagram
//
//  Created by Amr Hossam on 15/07/2021.
//

import UIKit

class ExploreViewController: UIViewController {
    
    
    
    private var collectionView: UICollectionView?
    private var searchButtons = [ButtonRenderer]()
    private var tabbedSearchCollectionView: UICollectionView?
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.isHidden = true
        return view
    }()
    
    private var models = [UserPost]()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .secondarySystemBackground
        searchBar.placeholder = "Search"
        return searchBar
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchbar()
        configureExploreCollection()
        configureDimmedView()
        configureTabbedSearch()
        fetchModels()
    }
    
    private func fetchModels() {
        DatabaseManager.shared.listenForPostsAdded { sucess, results in
            if sucess {
                self.models = results
                self.collectionView?.reloadData()
            }
        }
    }
    
    private func configureTabbedSearch() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.width/3, height: 42)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        tabbedSearchCollectionView = UICollectionView(frame: .zero,
                                                      collectionViewLayout: layout)
        tabbedSearchCollectionView?.isHidden = true
        guard let tabbedSearchCollectionView = tabbedSearchCollectionView else {
            return
        }
        tabbedSearchCollectionView.delegate = self
        tabbedSearchCollectionView.dataSource = self
        tabbedSearchCollectionView.register(TabbedSearchCollectionViewCell.self, forCellWithReuseIdentifier: TabbedSearchCollectionViewCell.identifier)
        view.addSubview(tabbedSearchCollectionView)
        searchButtons.append(ButtonRenderer(type: .people))
        searchButtons.append(ButtonRenderer(type: .tag))
        searchButtons.append(ButtonRenderer(type: .location))
    }
    
    private func configureDimmedView() {
        view.addSubview(dimmedView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didCancelSearch))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        dimmedView.addGestureRecognizer(gesture)
    }
    private func configureSearchbar() {
        navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.delegate = self
    }
    
    
    override func viewDidLayoutSubviews() {
        collectionView?.frame = view.bounds
        dimmedView.frame = view.bounds
        tabbedSearchCollectionView?.frame = CGRect(x: 0,
                                                   y: view.safeAreaInsets.top,
                                                   width: view.width,
                                                   height: 42)
    }
    
    
    private func configureExploreCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.width/3 - 1, height: view.width/3 - 1)
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(PhotoCollectionViewCell.self,
                                 forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
}



extension ExploreViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tabbedSearchCollectionView {
            return 3
        }
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if collectionView == tabbedSearchCollectionView {
            return
        }
        let post = models[indexPath.row]
        let vc = PostViewController(model: post)
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = post.postType.rawValue
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabbedSearchCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabbedSearchCollectionViewCell.identifier, for: indexPath) as! TabbedSearchCollectionViewCell
            cell.backgroundColor = .systemBackground
            cell.configure(with: searchButtons[indexPath.row])
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath)
                as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: models[indexPath.row])
        return cell
    }
    
    
}

extension ExploreViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        didCancelSearch()
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        query(text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didCancelSearch))
        navigationItem.rightBarButtonItem?.tintColor = .label
        dimmedView.isHidden = false
        self.tabbedSearchCollectionView?.isHidden = false

        UIView.animate(withDuration: 0.2, animations: {
            self.dimmedView.alpha = 0.4
        }) {
            done in
            if done {
            }
        }
        
    }
    
    @objc private func didCancelSearch() {
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        UIView.animate(withDuration: 0.2, animations: {
            self.dimmedView.alpha = 0
            self.tabbedSearchCollectionView?.isHidden = true
        }) { done in
            if done {
                self.dimmedView.isHidden = true
            }
        }
    }
    
    private func query(_ text: String) {
        print(text)
    }
}
