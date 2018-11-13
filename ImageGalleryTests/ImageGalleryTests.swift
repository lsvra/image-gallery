//
//  ImageGalleryTests.swift
//  ImageGalleryTests
//
//  Created by Luís Vieira on 30/10/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import XCTest
@testable import ImageGallery

class ImageGalleryTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testURLBuiler() {
        
        // 1. given
        let urlRequest = RequestsBuilder.builder
            .baseUrl("https://api.flickr.com/services/rest/")
            .method("flickr.photos.search")
            .apiKey("YOUR_API_KEY")
            .tag("Uma tag com vários espaços e caracteres especiais")
            .page("1")
            .format("json")
            .noJsonCallback("1")
            .build()
        
        // 2. when
        let urlString = urlRequest?.url?.absoluteString
        
        // 3. then
        XCTAssertEqual(urlString, "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=YOUR_API_KEY&tags=Uma%20tag%20com%20v%C3%A1rios%20espa%C3%A7os%20e%20caracteres%20especiais&page=1&format=json&nojsoncallback=1", "The url is malformed")
    }
}
