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
    
    private let url: URL
    private let queue = OperationQueue()
    
    init(url: URL) {
        self.url = url
    }
}

extension SingleImageInteractor: SingleImageInteractorProtocol {
    
    func requestImage() {
        
        let dataLoader = DataLoadOperation(url: url, session: .shared)
        
        dataLoader.completion = { [weak self] data, response, error in
            
            guard let self = self else {
                return
            }
            
            if let error = error {
                self.output?.presentError(error: error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            self.output?.presentImage(data: data)
        }
        
        queue.addOperation(dataLoader)
    }
}
