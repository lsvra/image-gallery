//
//  ImageCellViewModel.swift
//  ImageGallery
//
//  Created by Luís Vieira on 04/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation
import UIKit

class ImageCellViewModel {
    
    var setImage: ((_ image: UIImage) -> Void)?
    
    func setImage(from urlString: String){
        let imageUrlString = urlString
        
        //First we try to use a cached image
        if let imageFromCache = cache.object(forKey: urlString as NSString) {
            self.setImage?(imageFromCache)
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    
                    if imageUrlString == urlString {
                        self.setImage?(imageToCache!)
                    }
                    
                    cache.setObject(imageToCache!, forKey: urlString as NSString)
                }
            }
        }.resume()
    }
    
}
