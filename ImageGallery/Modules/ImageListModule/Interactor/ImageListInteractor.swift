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
    
    private var tag: String = ""
    
    private var queue: OperationQueue
    private var session: URLSession
    
    init(queue: OperationQueue, session: URLSession) {
        self.queue = queue
        self.session = session
    }
}

extension ImageListInteractor: ImageListInteractorProtocol {

    func requestImageList(tag: String?, page: Int) {
        
        if let tag = tag {
            self.tag = tag
        }
        
        let endpoint = Endpoint.search(for: self.tag, page: page)
        
        guard let url = endpoint.url else {
            return
        }
        
        let dataLoader = DataLoadOperation(url: url, session: session)
        
        dataLoader.completion = { [weak self] data, response, error in
            
            guard let self = self else {
                return
            }
            
            if let error = error {
                self.output?.presentError(error)
                return
            }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(PageEntity.self, from: data)
                    
                    if page == 1 {
                        self.output?.presentImageList(page: result)
                        return
                    }
                    
                    self.output?.updateImageList(page: result)
                    
                } catch let error {
                    self.output?.presentError(error)
                }
            }
        }
        
        queue.addOperation(dataLoader)
    }
}
