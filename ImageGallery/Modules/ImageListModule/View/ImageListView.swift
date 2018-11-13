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
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: ImageCell.nibName, bundle: nil),
                                forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        
        labelEmpty.text = "table_empty".overrideLocalizedString()
    }
}

//MARK: ImageListViewProtocol Delegate
extension ImageListView: ImageListViewProtocol {
    func displayError(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "error_action_ok".overrideLocalizedString(),
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func displayImageList(dataSource: UICollectionViewDataSource) {
        
        DispatchQueue.main.async {
            self.collectionView.dataSource = dataSource
            self.collectionView.reloadData()
            self.labelEmpty.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
    
    func updateImageList() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
