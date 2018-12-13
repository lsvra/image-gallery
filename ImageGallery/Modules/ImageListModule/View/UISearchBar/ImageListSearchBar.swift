//
//  ImageListSearchBar.swift
//  ImageGallery
//
//  Created by Luís Vieira on 13/12/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import UIKit

extension ImageListView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let tag = searchController.searchBar.text, !tag.isEmpty {
            
            presenter?.showImageList(tag: tag, page: 1)
            searchController.dismiss(animated: true, completion: nil)
        }
    }
}
