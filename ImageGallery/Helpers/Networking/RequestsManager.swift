//
//  RequestsManager.swift
//  ImageGallery
//
//  Created by Luís Vieira on 31/10/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation

final class RequestsManager {
    
    class func getData(endPoint: Endpoint,
                       session: URLSession,
                       completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error : Error?) -> Void) {
        
        guard let isConnected = try? Reachability()?.isConnectedToNetwork, isConnected == true else {
            completion(nil, nil, nil)
            return
        }
        
        guard let url = endPoint.url else {
            completion(nil, nil, nil)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            completion(data, response, error)
        })
        
        task.resume()
    }
}
