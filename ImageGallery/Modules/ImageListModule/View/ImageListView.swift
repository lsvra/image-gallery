//
//  ImageListView.swift
//  ImageGallery
//
//  Created by Luís Vieira on 30/10/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation
import UIKit

class ImageListView: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var labelEmpty: UILabel!
    
    //MARK: VIPER Protocols
    var presenter: ImageListPresenterProtocol?
    
    //MARK: Vars    
    var itemsPerRow: Int = 2
    let sectionInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    
    var items: [ImageReference] = [ImageReference]()
    
    let queue = OperationQueue()
    var loadingOperations: [IndexPath: DataLoadOperation] = [:]
    let threshold: Int = 20
    
    lazy var searchController: UISearchController = {
        
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.searchBarStyle = .minimal
        
        return searchController
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: self.view.frame,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        
        collectionView.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        return collectionView
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = searchController.searchBar
        self.definesPresentationContext = true
        
        self.view.addSubview(collectionView)
    }

    //TODO: Remove this method from the view
    public func loadData(at index: Int) -> DataLoadOperation? {
        
        if (0..<items.count).contains(index) {
            if let url = items[index].imageURL(.largeSquare){
                return DataLoadOperation(url: url, session: .shared)
            }
        }
        
        return nil
    }
}

//MARK: ImageListViewProtocol Delegate
extension ImageListView: ImageListViewProtocol {
    
    func displayImageList(images: [ImageReference], append: Bool) {
        
        if append {
            self.items.append(contentsOf: images)
        } else {
            self.items = images
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func displaySingleImage(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func displayError(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "error_action_ok".localized(),
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
