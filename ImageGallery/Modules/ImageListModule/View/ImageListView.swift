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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelEmpty: UILabel!
    
    //MARK: VIPER Protocols
    var presenter: ImageListPresenterProtocol?
    
    //MARK: Vars
    static let identifier: String = "ImageListView"
    static let storyboard: String = "ImageList"
    
    var itemsPerRow: Int = 2
    let sectionInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    
    var items: [ImageReference] = [ImageReference]()
    
    let queue = OperationQueue()
    var loadingOperations: [IndexPath: DataLoadOperation] = [:]
    let threshold: Int = 20
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        labelEmpty.text = "table_empty".localized()
    }
    
    public func loadData(at index: Int) -> DataLoadOperation? {
        
        if (0..<items.count).contains(index) {
            if let url = items[index].flickrImageURL(){
                return DataLoadOperation(url: url, session: .shared)
            }
        }
        
        return nil
    }
}

//MARK: ImageListViewProtocol Delegate
extension ImageListView: ImageListViewProtocol {
    
    func displayError(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "error_action_ok".localized(),
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func displayImageList(images: [ImageReference]) {
        
        self.items = images
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.labelEmpty.isHidden = true
        }
    }
    
    func updateImageList(images: [ImageReference]) {
        
        self.items.append(contentsOf: images)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

