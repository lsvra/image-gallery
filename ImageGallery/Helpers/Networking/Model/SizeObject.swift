//
//  Size.swift
//  ImageGallery
//
//  Created by Luís Vieira on 31/10/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation

struct SizeObject: Codable {
    var sizes: SizesObject?
}

struct SizesObject: Codable {
    var size: [Image]?
}

struct Image: Codable {
    var label: String?
    var source: String?
}
