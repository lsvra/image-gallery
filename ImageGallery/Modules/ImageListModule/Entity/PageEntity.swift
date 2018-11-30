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
    func flickrImageURL(_ size: String = "m") -> URL? {
        if let url =  URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg") {
            return url
        }
        return nil
    }
}
