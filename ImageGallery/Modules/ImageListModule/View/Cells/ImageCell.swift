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
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let reuseIdentifier: String = "ImageCell"
    static let nibName: String = "ImageCell"
    
    var loader: UIView? = nil
    let viewModel: ImageCellViewModel = ImageCellViewModel()
    
    func setup(image: SizesObject){
        
        guard let imageSizes = image.size, !imageSizes.isEmpty else {
            return
        }
        
        setupViewModelListeners()
        
        let imageToUse = imageSizes.filter({ $0.label == "Large Square"}).first
        
        if let source = imageToUse?.source {
            imageView.image = nil
            showLoader()
            viewModel.setImage(from: source)
        }
    }
    
    func setupViewModelListeners() {
        
        viewModel.setImage = { [weak self] image in
            self?.hideLoader()
            self?.imageView.image = image
        }
    }
    
    //MARK: Loaders
    func showLoader() {
        
        loader = UIView(frame: self.bounds)
        
        guard let loader = loader else {
            return
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        
        activityIndicator.startAnimating()
        activityIndicator.center = loader.center
        
        DispatchQueue.main.async {
            
            if loader == self.loader {
                loader.addSubview(activityIndicator)
                self.addSubview(loader)
            }
        }
    }
    
    func hideLoader() {
        guard let loader = loader else {
            return
        }
        
        DispatchQueue.main.async {
            
            if loader == self.loader {
                loader.removeFromSuperview()
            }
        }
    }
}
