//
//  NetworkingTests.swift
//  ImageGalleryTests
//
//  Created by Luís Vieira on 18/12/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

@testable import ImageGallery
import XCTest

class NetworkingTests: XCTestCase {
    
    func testUrlStringCreation(){
        
        // 1. given
        let searchTag = "String with spaces and punctuation."
        let page = 1
        
        // 2. when
        let endpoint = Endpoint.search(for: searchTag, page: 1)
        
        // 3. then
        guard let encodedSearchTag = searchTag.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            XCTFail("Fail: The search tag is nil")
            return
        }
        
        guard let endpointUrl = endpoint.url?.absoluteString else {
            XCTFail("Fail: The endpoint url string is nil")
            return
        }
        
        let expectedUrl = "https://api.flickr.com/services/rest?method=flickr.photos.search&api_key=API_KEY_HERE&tags=\(encodedSearchTag)&page=\(page)&format=json&nojsoncallback=1"
        
        XCTAssertEqual(endpointUrl, expectedUrl, "Fail: The url string is malformed")
    }
    
    func testDataLoadOperation() {
        
        // 1. given
        let urlString = "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"
        let queue = OperationQueue()
        let session = URLSession(configuration: .default)
        
        let promise = expectation(description: "Completion handler invoked")
        
        var statusCode: Int?
        var responseError: Error?
        
        // 2. when
        guard let url = URL(string: urlString) else {
            XCTFail("Fail: The url is nil")
            return
        }
        
        let dataLoader = DataLoadOperation(url: url, session: session)
        
        dataLoader.completion = { data, response, error in
            
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            
            promise.fulfill()
        }
    
        queue.addOperation(dataLoader)
        
        waitForExpectations(timeout: 10, handler: nil)
        
        // 3. then
        XCTAssertNil(responseError, "Fail: The request returned an error")
        XCTAssertEqual(statusCode, 200, "Fail: The status code is different from 200")
    }
}
