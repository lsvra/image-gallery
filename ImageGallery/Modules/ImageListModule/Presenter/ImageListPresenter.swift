//
//  ImageListPresenter.swift
//  ImageGallery
//
//  Created by Luís Vieira on 30/10/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation

class ImageListPresenter {
    
    //VIPER delegates
    weak var view: ImageListViewProtocol?
    var interactor: ImageListInteractorProtocol?
    var router: ImageListRouterProtocol?
}

extension ImageListPresenter: ImageListPresenterProtocol {

    func showImageList(tag: String, page: Int) {
        interactor?.requestImageList(tag: tag, page: page)
    }
    
    func showSingleImage(item: ImageReference) {
        
        if let url = item.imageURL(.mediumHigh) {
            let module = SingleImageRouter.setupModule(url: url)
            view?.displaySingleImage(module)
        }
    }
}

extension ImageListPresenter: ImageListOutputProtocol{
    
    func presentImageList(page: PageEntity) {
        
        let imagesArray: [ImageReference] = page.photos.photo

        view?.displayImageList(images: imagesArray, append: false)
    }
    
    func updateImageList(page: PageEntity) {
        
        let imagesArray: [ImageReference] = page.photos.photo
        
        view?.displayImageList(images: imagesArray, append: true)
    }
    
    func presentError(_ error: Error) {
        
        let title: String = "error_title".localized()
        let message: String = error.localizedDescription
        
        view?.displayError(title: title, message: message)
    }
}
