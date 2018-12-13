//
//  SingleImageView.swift
//  ImageGallery
//
//  Created by Luís Vieira on 03/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation
import UIKit

class SingleImageView: UIViewController {

    //MARK: VIPER Protocols
    var presenter: SingleImagePresenterProtocol?
    
    //MARK: Vars
    lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView(frame: self.view.frame)
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        scrollView.addSubview(imageView)
        
        return scrollView
    }()
    
    lazy var imageView: UIImageView = {
        
        let imageView = UIImageView(frame: self.view.frame)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.sampleTapGestureTapped(recognizer:)))
        
        doubleTap.numberOfTapsRequired = 2
        
        imageView.addGestureRecognizer(doubleTap)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(scrollView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.showImage()
    }
    
    @objc func sampleTapGestureTapped(recognizer: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            let currentZoom = self.scrollView.zoomScale
            self.scrollView.zoomScale = currentZoom > 1.0 ? 1.0 : 5.0
        })
    }
}

//MARK: UIScrollViewDelegate Delegate
extension SingleImageView: UIScrollViewDelegate  {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

//MARK: SingleImageViewProtocol Delegate
extension SingleImageView: SingleImageViewProtocol {
    
    func displayImage(image: UIImage) {
        
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    func displayError(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "error_action_ok".localized(),
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
