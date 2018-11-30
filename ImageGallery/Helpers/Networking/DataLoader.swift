//
//  DataLoader.swift
//  ImageGallery
//
//  Created by Luís Vieira on 29/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation

class DataLoadOperation: Operation {
    
    // 1
    var data: Data?
    var loadingCompleteHandler: ((Data) -> Void)?
    
    private let _url: URL
    
    // 2
    init(url: URL) {
        _url = url
    }
    
    // 3
    override func main() {
        
        if isCancelled {
            return
        }
        
        URLSession.shared.dataTask(with: _url) { data, response, error in
            
            if self.isCancelled {
                return
            }
            
            self.data = data
            
            if let data = data {
                if let loadingCompleteHandler = self.loadingCompleteHandler {
                    loadingCompleteHandler(data)
                }
            }
            
        }.resume()
    }
}
