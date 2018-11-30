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
        
        let endpoint = Endpoint.search(for: tag, page: String(describing: page))
        
        RequestsManager.getData(endPoint: endpoint, session: .shared, completion: { data, response, error in
            
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
        })
    }
    
    func requestNextPage() {
        page = page + 1
        
        let endpoint = Endpoint.search(for: tag, page: String(describing: page))
        
        RequestsManager.getData(endPoint: endpoint, session: .shared, completion: { data, response, error in
            
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
        })
    }
}
