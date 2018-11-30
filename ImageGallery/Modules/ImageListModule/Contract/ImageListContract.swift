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
    
    func displayImageList(images: [ImageReference])
    func updateImageList(images: [ImageReference])
    
    func displayError(title: String, message: String)

}

//MARK: Presenter Input
protocol ImageListPresenterProtocol: class {
    
    var view: ImageListViewProtocol?                { get set }
    var interactor: ImageListInteractorProtocol?    { get set }
    var router: ImageListRouterProtocol?            { get set }
    
    func showImageList(tag: String)
    func showImageListNextPage()
    func showSingleImage(index: Int)
}

//MARK: Presenter Output
protocol ImageListOutputProtocol: class {
    
    func presentImageList(page: PageEntity)
    func updateImageList(page: PageEntity)
    
    func presentError(error: Error)
}

//MARK: Interactor
protocol ImageListInteractorProtocol: class {
    
    var output: ImageListOutputProtocol?      { get set }
    
    func requestImageList(tag: String)
    func requestNextPage()
}


