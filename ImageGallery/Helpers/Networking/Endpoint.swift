//
//  Endpoint.swift
//  ImageGallery
//
//  Created by Luís Vieira on 27/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation

// Constants that are used more than once
struct APIConstants {
    
    fileprivate static let apiKey: String = "dd919992810441c7c24164a0b11f8b56"
    
    fileprivate static let scheme: String = "https"
    fileprivate static let host: String = "api.flickr.com"
    fileprivate static let path: String = "/services/rest"
    
    fileprivate static let format: String = "json"
    fileprivate static let noJsonCallback: String = "1"
}

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = APIConstants.scheme
        components.host = APIConstants.host
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}

extension Endpoint {
    static func search(for tag: String, page: String) -> Endpoint {
        
        return Endpoint(
            path: APIConstants.path,
            queryItems: [URLQueryItem(name: "method", value: "flickr.photos.search"),
                         URLQueryItem(name: "api_key", value: APIConstants.apiKey),
                         URLQueryItem(name: "tags", value: tag),
                         URLQueryItem(name: "page", value: page),
                         URLQueryItem(name: "format", value: APIConstants.format),
                         URLQueryItem(name: "nojsoncallback", value: APIConstants.noJsonCallback)])
    }
}
