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
        
        for indexPath in indexPaths {
            
            if loadingOperations[indexPath] != nil {
                continue
            }
            
            if let dataLoader = loadData(at: indexPath.item) {
                queue.addOperation(dataLoader)
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
