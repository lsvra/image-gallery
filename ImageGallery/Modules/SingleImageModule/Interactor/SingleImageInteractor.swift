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
    
    private let dataLoader: DataLoadOperation
    private let queue: OperationQueue
    
    init(queue: OperationQueue, dataLoader: DataLoadOperation) {
        self.queue = queue
        self.dataLoader = dataLoader
    }
}

extension SingleImageInteractor: SingleImageInteractorProtocol {
    
    func requestImage() {
        
        dataLoader.completion = { [weak self] data, response, error in
            
            guard let self = self else {
                return
            }
            
            if let error = error {
                self.output?.presentError(error)
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
