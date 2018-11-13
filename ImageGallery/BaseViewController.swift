//
//  ViewController.swift
//  ImageGallery
//
//  Created by Luís Vieira on 30/10/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var router: Router = {
        
        let router = Router.shared
        router.setBaseViewController(self)
        
        return router
    }()
    
    lazy var searchController: UISearchController = {
        
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.searchBarStyle = .minimal
        
        return searchController
    }()
    
    override func viewDidLoad() {
        
        self.navigationItem.titleView = searchController.searchBar
        self.definesPresentationContext = true
        
        router.openInitialViewController()
    }
    
    func setup(viewController: UIViewController){
        self.addChild(viewController)
        self.view.addSubview(viewController.view)
    }
    
    func push(viewController: UIViewController){
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: UISearchBar Delegate
extension BaseViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let tag = searchController.searchBar.text, !tag.isEmpty {
            
            router.openImageList(tagToSearch: tag)
            searchController.dismiss(animated: true, completion: nil)
        }
    }
}

