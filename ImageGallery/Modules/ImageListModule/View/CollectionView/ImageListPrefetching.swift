//
//  ImageListPrefetchDataSourve.swift
//  ImageGallery
//
//  Created by Luís Vieira on 04/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation
import UIKit

extension ImageListView: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        presenter?.validatePrefetch(indexPaths: indexPaths)
    }
}
