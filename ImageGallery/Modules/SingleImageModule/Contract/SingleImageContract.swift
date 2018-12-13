//
//  SingleImageContract.swift
//  ImageGallery
//
//  Created by Luís Vieira on 03/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation
import UIKit

//MARK: Router
protocol SingleImageRouterProtocol: class {
    // Empty
}

//MARK: View
protocol SingleImageViewProtocol: class {
    
    var presenter: SingleImagePresenterProtocol?      { get }
    
    func displayImage(image: UIImage)
    func displayError(title: String, message: String)
}

//MARK: Presenter Input
protocol SingleImagePresenterProtocol: class {
    
    var view: SingleImageViewProtocol?                  { get }
    var interactor: SingleImageInteractorProtocol?      { get }
    var router: SingleImageRouterProtocol?              { get }
    
    func showImage()
}

//MARK: Presenter Output
protocol SingleImageOutputProtocol: class {
    
    func presentImage(data: Data)
    func presentError(_ error: Error)
}

//MARK: Interactor
protocol SingleImageInteractorProtocol: class {
    
    var output: SingleImageOutputProtocol?      { get }
    
    func requestImage()
}


