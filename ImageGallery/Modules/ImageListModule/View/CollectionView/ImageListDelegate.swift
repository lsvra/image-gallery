//
//  ImageListDelegate.swift
//  ImageGallery
//
//  Created by Luís Vieira on 04/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import UIKit

extension ImageListView: UICollectionViewDelegate {
    
    public func loadData(at index: Int) -> DataLoadOperation? {
        
        if (0..<images.count).contains(index) {
            if let url = images[index].flickrImageURL(){
                return DataLoadOperation(url: url, session: .shared)
            }
        }
        
        return .none
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let cell = cell as? ImageCell else {
            return
        }
        
        // 1
        let updateCellClosure: (Data?, URLResponse?, Error?) -> Void = { [weak self] data, response, error in
            
            guard let self = self else {
                return
            }
            
            cell.setup(data: data!)
            self.loadingOperations.removeValue(forKey: indexPath)
        }
        
        // 2
        if let dataLoader = loadingOperations[indexPath] {
            // 3
            if let data = dataLoader.data {
                cell.setup(data: data)
                loadingOperations.removeValue(forKey: indexPath)
            } else {
                // 4
                dataLoader.completion = updateCellClosure
            }
        } else {
            // 5
            if let dataLoader = loadData(at: indexPath.item) {
                // 6
                dataLoader.completion = updateCellClosure
                // 7
                loadingQueue.addOperation(dataLoader)
                // 8
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
        presenter?.showSingleImage(index: indexPath.item)
    }
}
