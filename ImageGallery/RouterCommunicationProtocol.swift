//
//  RouterProtocol.swift
//  ImageGallery
//
//  Created by Luís Vieira on 03/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation

//MARK: Protocol to be used in communications of type (ModuleRouter -> Router)
protocol RouterCommunicationProtocol {
    
    func openSingleImage(urlString: String)
}
