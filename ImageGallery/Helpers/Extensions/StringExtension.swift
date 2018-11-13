//
//  StringExtension.swift
//  ImageGallery
//
//  Created by Luís Vieira on 04/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation

extension String {
    func overrideLocalizedString() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
