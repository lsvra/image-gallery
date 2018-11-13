//
//  SingleImageInteractor.swift
//  ImageGallery
//
//  Created by Luís Vieira on 03/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation

class SingleImageInteractor {
    weak var output: SingleImageOutputProtocol?
    
    let imageUrl: String
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
}

extension SingleImageInteractor: SingleImageInteractorProtocol {
    
    func requestImage() {
        RequestsManager.shared.getImage(imageUrl, completion: { data, error in
            
            if let error = error {
                self.output?.presentError(error: error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            self.output?.presentImage(data: data)
        })
    }
}
