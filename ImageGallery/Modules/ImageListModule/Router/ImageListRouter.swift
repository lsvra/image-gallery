//
//  ImageListRouter.swift
//  ImageGallery
//
//  Created by Luís Vieira on 30/10/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation
import UIKit

class ImageListRouter: ImageListRouterProtocol {

    static func setupModule() -> UIViewController {
        
        //Create DI classes
        let queue = OperationQueue()
        let session = URLSession.shared
        
        //Create VIPER classes
        let view = ImageListView()
        let interactor = ImageListInteractor(queue: queue, session: session)
        let router = ImageListRouter()
        let presenter = ImageListPresenter()
    
        //Connect View
        view.presenter = presenter
        
        //Connect Presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        //Connect Interactor
        interactor.output = presenter
    
        return view
    }
}
