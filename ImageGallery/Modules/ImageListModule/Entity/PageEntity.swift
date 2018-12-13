//
//  PageEntity.swift
//  ImageGallery
//
//  Created by FYI Admin on 30/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation

struct PageEntity: Decodable {
    var photos: PhotosEntity
}

struct PhotosEntity: Decodable {
    var page: Int
    var photo: [ImageReference]
}

struct ImageReference: Decodable {
    var id: String
    var farm: Int
    var server: String
    var secret: String
}

extension ImageReference {
    
    enum Size: String {
        case square = "sq"
        case largeSquare = "q"
        case thumbnail = "t"
        case small = "s"
        case medium = "m"
        case mediumHigh = "c"
        case large = "l"
        case original = "o"
    }
    
    func imageURL(_ size: Size) -> URL? {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size.rawValue).jpg")
    }
}
