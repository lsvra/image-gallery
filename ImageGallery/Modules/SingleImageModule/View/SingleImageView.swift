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
    
    //MARK: IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: VIPER Protocols
    var presenter: SingleImagePresenterProtocol?
    
    //MARK: Vars
    static let identifier: String = "SingleImageView"
    static let storyboard: String = "SingleImage"
    
    var loader: UIView?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.sampleTapGestureTapped(recognizer:)))
        doubleTap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(doubleTap)
        imageView.isUserInteractionEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.showImage()
    }
    
    @objc func sampleTapGestureTapped(recognizer: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            let currentZoom = self.scrollView.zoomScale
            self.scrollView.zoomScale = currentZoom > 1.0 ? 1.0 : 5.0
        })
        
    }
}

//MARK: SingleImageViewProtocol Delegate
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
