//
//  ImageListPresenter.swift
//  ImageGallery
//
//  Created by Luís Vieira on 30/10/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation

class ImageListPresenter {
    
    weak var view: ImageListViewProtocol?
    var interactor: ImageListInteractorProtocol?
    var router: ImageListRouterProtocol?
}

extension ImageListPresenter: ImageListPresenterProtocol {

    func showImageList(tag: String) {
        interactor?.requestImageList(tag: tag)
    }
    
    func showImageListNextPage() {
        interactor?.requestNextPage()
    }
    
    func showSingleImage(item: ImageReference) {
        
        if let url = item.flickrImageURL() {
            router?.openSingleImage(url: url)
        }
    }
}

extension ImageListPresenter: ImageListOutputProtocol{
    
    func presentImageList(page: PageEntity) {
        
        let imagesArray: [ImageReference] = page.photos.photo
        
        view?.displayImageList(images: imagesArray)
    }
    
    func updateImageList(page: PageEntity) {
        
        let imagesArray: [ImageReference] = page.photos.photo
        
        view?.updateImageList(images: imagesArray)
    }
    
    func presentError(error: Error) {
        
        let title: String = "error_title".localized()
        let message: String = error.localizedDescription
        
        view?.displayError(title: title, message: message)
    }
}
