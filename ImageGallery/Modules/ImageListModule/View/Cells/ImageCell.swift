//
//  ImageCell.swift
//  ImageGallery
//
//  Created by Luís Vieira on 30/10/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation
import UIKit

class ImageCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    static let reuseIdentifier: String = "ImageCell"
    
    var url = ""
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: bounds)
        
        contentView.addSubview(imageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    func setup(data: Data){
        
        guard let image = UIImage(data: data) else {
            return
        }
        
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
