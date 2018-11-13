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

    var dataSource = ImageListDataSource()
    
}

extension ImageListPresenter: ImageListPresenterProtocol{

    func showImageList(tag: String) {
        interactor?.requestImageList(tag: tag)
    }
    
    func showSingleImage(index: Int) {
        
        if let urlString = dataSource.images[index].size?.last?.source {
            router?.openSingleImage(urlString: urlString)
        }
    }
    
    func validatePrefetch(indexPaths: [IndexPath]) {
        let threshold: Int = 20
        
        if let lastIndex = indexPaths.last?.item {
            if lastIndex + threshold >= dataSource.images.count {
                interactor?.requestNextPage()
            }
        }
        
    }
}

extension ImageListPresenter: ImageListOutputProtocol{
    
    func presentImageList(images: [SizesObject]) {
        
        dataSource.images = images
        view?.displayImageList(dataSource: dataSource)
    }
    
    func updateImageList(images: [SizesObject]) {
        
        dataSource.images.append(contentsOf: images)
        view?.updateImageList()
    }
    
    func presentError(error: NSError) {
        
        let title: String = "error_title".overrideLocalizedString()
        let message: String = error.localizedFailureReason?.overrideLocalizedString() ?? ""
        
        view?.displayError(title: title, message: message)
    }
}
