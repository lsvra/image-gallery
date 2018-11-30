//
//  ImageListDelegate.swift
//  ImageGallery
//
//  Created by Luís Vieira on 04/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import UIKit

extension ImageListView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showSingleImage(index: indexPath.item)
    }
}
