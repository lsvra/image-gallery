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
    //Empty
}

//MARK: View
protocol ImageListViewProtocol: class {
    
    var presenter: ImageListPresenterProtocol?      { get }
    
    func displayImageList(images: [ImageReference], append: Bool)
    func displaySingleImage(_ viewController: UIViewController)
    func displayError(title: String, message: String)
}

//MARK: Presenter Input
protocol ImageListPresenterProtocol: class {
    
    var view: ImageListViewProtocol?                { get }
    var interactor: ImageListInteractorProtocol?    { get }
    var router: ImageListRouterProtocol?            { get }
    
    func showImageList(tag: String, page: Int)
    func showSingleImage(item: ImageReference)
}

//MARK: Presenter Output
protocol ImageListOutputProtocol: class {
    
    func presentImageList(page: PageEntity)
    func updateImageList(page: PageEntity)
    
    func presentError(_ error: Error)
}

//MARK: Interactor
protocol ImageListInteractorProtocol: class {
    
    var output: ImageListOutputProtocol?      { get }
    
    func requestImageList(tag: String?, page: Int)
}


