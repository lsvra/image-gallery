//
//  DataLoader.swift
//  ImageGallery
//
//  Created by Luís Vieira on 29/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation

let cache = NSCache<NSString, NSData>()

class DataLoadOperation: Operation {
    
    var data: Data?
    var completion: ((Data?, URLResponse?, Error?) -> Void)?
    
    private let url: URL
    private let session: URLSession
    
    init(url: URL, session: URLSession) {
        self.url = url
        self.session = session
    }
    
    // TODO: Implement Reachability
    
    override func main() {
        
        // Use data from cache if available
        if let cachedData = cache.object(forKey: url.absoluteString as NSString),
            let completion = self.completion {
            
                data = Data(referencing: cachedData)
                completion(data, nil, nil)
                return
        }
        
        if isCancelled {
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if self.isCancelled {
                return
            }
            
            // Cache data for future use
            if let data = data {
                let dataToCache = NSData(data: data)
                cache.setObject(dataToCache, forKey: self.url.absoluteString as NSString)
            }

            self.data = data
        
            if let completion = self.completion {
                completion(data, response, error)
            }
        }
        
        task.resume()
    }
}
