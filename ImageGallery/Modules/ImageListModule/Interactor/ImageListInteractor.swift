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
    private let queue = OperationQueue()
}

extension ImageListInteractor: ImageListInteractorProtocol {

    func requestImageList(tag: String) {
        
        self.tag = tag
        page = 1
        
        let endpoint = Endpoint.search(for: tag, page: String(describing: page))
        
        guard let url = endpoint.url else {
            return
        }
        
        let dataLoader = DataLoadOperation(url: url, session: .shared)
        
        dataLoader.completion = { [weak self] data, response, error in
            
            guard let self = self else {
                return
            }
            
            if let error = error {
                self.output?.presentError(error: error)
                return
            }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(PageEntity.self, from: data)
                    self.output?.presentImageList(page: result)
                    
                } catch let error {
                    self.output?.presentError(error: error)
                    return
                }
            }
        }
        
        queue.addOperation(dataLoader)
    }
    
    func requestNextPage() {
        page = page + 1
        
        let endpoint = Endpoint.search(for: tag, page: String(describing: page))

        guard let url = endpoint.url else {
            return
        }
        
        let dataLoader = DataLoadOperation(url: url, session: .shared)
        
        dataLoader.completion = { [weak self] data, response, error in
            
            guard let self = self else {
                return
            }
            
            if let error = error {
                self.output?.presentError(error: error)
                return
            }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(PageEntity.self, from: data)
                    self.output?.updateImageList(page: result)
                    
                } catch let error {
                    self.output?.presentError(error: error)
                    return
                }
            }
        }

        queue.addOperation(dataLoader)
    }
}
