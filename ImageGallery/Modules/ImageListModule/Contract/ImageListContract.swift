//
//  ImageListContract.swift
//  ImageGallery
//
//  Created by Luís Vieira on 30/10/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation
import UIKit

//MARK: Router
protocol ImageListRouterProtocol: class {
    func openSingleImage(urlString: String)
}

//MARK: View
protocol ImageListViewProtocol: class {

    var presenter: ImageListPresenterProtocol?      { get set }
    
    func displayImageList(dataSource: UICollectionViewDataSource)
    func updateImageList()
    
    func displayError(title: String, message: String)

}

//MARK: Presenter Input
protocol ImageListPresenterProtocol: class {
    
    var view: ImageListViewProtocol?                { get set }
    var interactor: ImageListInteractorProtocol?    { get set }
    var router: ImageListRouterProtocol?            { get set }
    
    func showImageList(tag: String)
    func showSingleImage(index: Int)
    func validatePrefetch(indexPaths: [IndexPath])
}

//MARK: Presenter Output
protocol ImageListOutputProtocol: class {
    
    func presentImageList(images: [SizesObject])
    func updateImageList(images: [SizesObject])
    
    func presentError(error: NSError)
}

//MARK: Interactor
protocol ImageListInteractorProtocol: class {
    
    var output: ImageListOutputProtocol?      { get set }
    
    func requestImageList(tag: String)
    func requestNextPage()
}


