//
//  RequestsContract.swift
//  ImageGallery
//
//  Created by Luís Vieira on 01/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation

protocol BuildStep {
    
    func build() -> URLRequest?
}

protocol BaseUrlStep {
    
    func baseUrl(_ url: String) -> MethodStep
}

protocol MethodStep {
    
    func method(_ method: String) -> KeyStep
}

protocol KeyStep {
    
    func apiKey(_ apiKey: String) -> OptionsStep
}

protocol OptionsStep {
    
    func tag(_ tag: String) -> PaginationStep
    func photoId(_ photoId: String) -> FormatStep
}

protocol PaginationStep {
    
    func page(_ page: String) -> FormatStep
}

protocol FormatStep {
    
    func format(_ format: String) -> NoJsonCallbackStep
}

protocol NoJsonCallbackStep {
    
    func noJsonCallback(_ noJsonCallback: String) -> BuildStep
}
