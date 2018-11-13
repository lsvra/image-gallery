//
//  RequestsBuilder.swift
//  ImageGallery
//
//  Created by Luís Vieira on 01/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation

// Constants that are used more than once
struct APIConstants {
    
    fileprivate static let baseUrl: String = "https://api.flickr.com/services/rest/"
    fileprivate static let apiKey: String = "YOUR_API_KEY"
    
    fileprivate static let format: String = "json"
    fileprivate static let noJsonCallback: String = "1"
}

struct Request {
    fileprivate(set) var requestArray: [String] = []
}

class RequestsBuilder {
    
    fileprivate var request: Request!
    
    private init() {
        // Mandatory private init
    }
    
    private init(_ request: Request) {
        
        self.request = request
    }
    
    class var builder: BaseUrlStep {
        
        return RequestsBuilder(Request()) as BaseUrlStep
    }
    
    class func pageRequest(with tag: String, and page: String) -> URLRequest? {
        
        return RequestsBuilder.builder
            .baseUrl(APIConstants.baseUrl)
            .method("flickr.photos.search")
            .apiKey(APIConstants.apiKey)
            .tag(tag)
            .page(page)
            .format(APIConstants.format)
            .noJsonCallback(APIConstants.noJsonCallback)
            .build()
    }
    
    class func sizesRequest(with photoId: String) -> URLRequest? {
        
        return RequestsBuilder.builder
            .baseUrl(APIConstants.baseUrl)
            .method("flickr.photos.getSizes")
            .apiKey(APIConstants.apiKey)
            .photoId(photoId)
            .format(APIConstants.format)
            .noJsonCallback(APIConstants.noJsonCallback)
            .build()
    }
    
    class func singleImageRequest(with urlString: String) -> URLRequest?{
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        return URLRequest(url: url)
    }
}

extension RequestsBuilder: BuildStep, BaseUrlStep, MethodStep, KeyStep, OptionsStep, PaginationStep, FormatStep, NoJsonCallbackStep {
    
    func build() -> URLRequest? {
        
        let urlString = request.requestArray.reduce("", +)
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        return URLRequest(url: url)
    }
    
    func baseUrl(_ url: String) -> MethodStep {
        
        request.requestArray.append(url)
        return self
    }
    
    func method(_ method: String) -> KeyStep {
        
        let method = "?method=".appending(method)
        request.requestArray.append(method)
        return self
    }
    
    func apiKey(_ apiKey: String) -> OptionsStep {
        
        let apiKey = "&api_key=".appending(apiKey)
        request.requestArray.append(apiKey)
        return self
    }
    
    func tag(_ tag: String) -> PaginationStep {
        
        let tag = tag.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
        request.requestArray.append("&tags=\(tag)")
        return self
    }
    
    func page(_ page: String) -> FormatStep {
        
        let page = "&page=".appending(page)
        request.requestArray.append(page)
        return self
    }
    
    func photoId(_ photoId: String) -> FormatStep {
        
        let photoId = "&photo_id=".appending(photoId)
        request.requestArray.append(photoId)
        return self
    }
    
    func format(_ format: String) -> NoJsonCallbackStep {
        
        let format = "&format=".appending(format)
        request.requestArray.append(format)
        return self
    }
    
    func noJsonCallback(_ noJsonCallback: String) -> BuildStep {
        
        let noJsonCallback = "&nojsoncallback=".appending(noJsonCallback)
        request.requestArray.append(noJsonCallback)
        return self
    }
    
}
