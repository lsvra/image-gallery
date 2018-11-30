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
    }
}
