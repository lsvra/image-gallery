//
//  ImageListInteractor.swift
//  ImageGallery
//
//  Created by Luís Vieira on 30/10/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation

class ImageListInteractor {
    
    weak var output: ImageListOutputProtocol?
    
    private var page: Int = 1
    private var tag: String = ""
}

extension ImageListInteractor: ImageListInteractorProtocol {

    func requestImageList(tag: String) {
        
        self.tag = tag
        page = 1
        
        RequestsManager.shared.getPage(tag, page, completion: {images, error in
            
            if let error = error {
                self.output?.presentError(error: error)
                return
            }
            
            self.output?.presentImageList(images: images)
        })
    }
    
    func requestNextPage() {
        page = page + 1
        
        RequestsManager.shared.getPage(tag, page, completion: {images, error in
            
            if let error = error {
                self.output?.presentError(error: error)
                return
            }
            
            self.output?.updateImageList(images: images)
        })
    }
    
}
