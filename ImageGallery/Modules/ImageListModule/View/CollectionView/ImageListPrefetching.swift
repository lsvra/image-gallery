//
//  ImageListPrefetchDataSourve.swift
//  ImageGallery
//
//  Created by Luís Vieira on 04/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import UIKit

extension ImageListView: UICollectionViewDataSourcePrefetching {


    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        
        let threshold: Int = 20
        
        if let lastIndex = indexPaths.first?.item {
            if lastIndex + threshold >= images.count {
                presenter?.showImageListNextPage()
            }
        }
        
        for indexPath in indexPaths {
            
            if let _ = loadingOperations[indexPath] {
                continue
            }
            
            if let dataLoader = loadData(at: indexPath.item) {
                loadingQueue.addOperation(dataLoader)
                loadingOperations[indexPath] = dataLoader
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if let dataLoader = loadingOperations[indexPath] {
                dataLoader.cancel()
                loadingOperations.removeValue(forKey: indexPath)
            }
        }
    }
}
