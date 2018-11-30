//
//  ImageListDataSource.swift
//  ImageGallery
//
//  Created by Luís Vieira on 30/10/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import UIKit

extension ImageListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    public func loadEmojiRating(at index: Int) -> DataLoadOperation? {
        if (0..<images.count).contains(index) {
            return DataLoadOperation(url: images[index].flickrImageURL()!)
        }
        return .none
    }

    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
        guard let cell = cell as? ImageCell else {
            return
        }
        
        // 1
        let updateCellClosure: (Data?) -> Void = { [weak self] data in
            
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
                dataLoader.loadingCompleteHandler = updateCellClosure
            }
        } else {
            // 5
            if let dataLoader = loadEmojiRating(at: indexPath.item) {
                // 6
                dataLoader.loadingCompleteHandler = updateCellClosure
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
}
