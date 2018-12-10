//
//  DataLoader.swift
//  ImageGallery
//
//  Created by Luís Vieira on 29/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation

class DataLoadOperation: Operation {
    
    var data: Data?
    var completion: ((Data?, URLResponse?, Error?) -> Void)?
    
    private let url: URL
    private let session: URLSession
    
    init(url: URL, session: URLSession) {
        self.url = url
        self.session = session
    }
    
    override func main() {
        
        if isCancelled {
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if self.isCancelled {
                return
            }
            
            self.data = data
        
            if let completion = self.completion {
                completion(data, response, error)
            }
        }
        
        task.resume()
    }
}
