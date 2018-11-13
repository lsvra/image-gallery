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
    
}

//MARK: View
protocol SingleImageViewProtocol: class {
    
    var presenter: SingleImagePresenterProtocol?      { get set }
    
    func displayImage(image: UIImage)
    func displayError(title: String, message: String)
}

//MARK: Presenter Input
protocol SingleImagePresenterProtocol: class {
    
    var view: SingleImageViewProtocol?                { get set }
    var interactor: SingleImageInteractorProtocol?    { get set }
    var router: SingleImageRouterProtocol?            { get set }
    
    func showImage()
}

//MARK: Presenter Output
protocol SingleImageOutputProtocol: class {
    
    func presentImage(data: Data)
    func presentError(error: NSError)
}

//MARK: Interactor
protocol SingleImageInteractorProtocol: class {
    
    var output: SingleImageOutputProtocol?      { get set }
    
    func requestImage()
}


