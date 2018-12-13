//
//  SingleImageRouter.swift
//  ImageGallery
//
//  Created by Luís Vieira on 03/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation
import UIKit

class SingleImageRouter: SingleImageRouterProtocol {
    
    static func setupModule(url: URL) -> UIViewController {
        
        // Create DI classes
        let queue = OperationQueue()
        let dataLoader = DataLoadOperation(url: url, session: .shared)
        
        // Create VIPER classes
        let view = SingleImageView()
        let interactor = SingleImageInteractor(queue: queue, dataLoader: dataLoader)
        let router = SingleImageRouter()
        let presenter = SingleImagePresenter()
        
        // Connect View
        view.presenter = presenter
        
        // Connect Presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        // Connect Interactor
        interactor.output = presenter
        
        return view
    }
}
