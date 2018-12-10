//
//  ImageListDelegate.swift
//  ImageGallery
//
//  Created by Luís Vieira on 04/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import UIKit

extension ImageListView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let cell = cell as? ImageCell else {
            return
        }
        
        let closure: (Data?, URLResponse?, Error?) -> Void = { [weak self] data, response, error in
            
            guard let self = self else {
                return
            }
            
            if let data = data {
                cell.setup(data: data)
            }
            
            self.loadingOperations.removeValue(forKey: indexPath)
        }
        
        // When the cell is near the end of the array, there's a need for a new network request
        if indexPath.item == items.count - threshold {
            presenter?.showImageListNextPage()
        }
        
        if let dataLoader = loadingOperations[indexPath] {
            
            if let data = dataLoader.data {
                cell.setup(data: data)
                loadingOperations.removeValue(forKey: indexPath)
            } else {
                dataLoader.completion = closure
            }
        } else {
            
            if let dataLoader = loadData(at: indexPath.item) {
                
                dataLoader.completion = closure
                
                queue.addOperation(dataLoader)

                loadingOperations[indexPath] = dataLoader
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let dataLoader = loadingOperations[indexPath] {
            dataLoader.cancel()
            loadingOperations.removeValue(forKey: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
        let index = indexPath.item
        
        if (0..<items.count).contains(index) {
            presenter?.showSingleImage(item: items[index])
        }
    }
}
