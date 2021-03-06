//
//  SingleImagePresenter.swift
//  ImageGallery
//
//  Created by Luís Vieira on 03/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation
import UIKit

class SingleImagePresenter {
    
    weak var view: SingleImageViewProtocol?
    var interactor: SingleImageInteractorProtocol?
    var router: SingleImageRouterProtocol?
}

extension SingleImagePresenter: SingleImagePresenterProtocol{
    
    func showImage() {
        interactor?.requestImage()
    }
}

extension SingleImagePresenter: SingleImageOutputProtocol{
    
    func presentImage(data: Data) {
        
        guard let image = UIImage(data: data) else {
            return
        }
    
        view?.displayImage(image: image)
    }
    
    func presentError(_ error: Error) {
        let title: String = "error_title".localized()
        let message: String = error.localizedDescription
        
        view?.displayError(title: title, message: message)
    }
}
