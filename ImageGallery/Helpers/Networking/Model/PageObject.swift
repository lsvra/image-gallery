//
//  Photo.swift
//  ImageGallery
//
//  Created by Luís Vieira on 31/10/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation

struct PageObject: Codable {
    var photos: PhotosObject?
}

struct PhotosObject: Codable {
    var page: Int?
    var photo: [ImageReference]?
}

struct ImageReference: Codable {
    var id: String?
}

