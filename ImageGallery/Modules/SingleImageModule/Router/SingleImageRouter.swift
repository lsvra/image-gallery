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
    
    weak var viewController: UIViewController?
    
    static func setupModule(imageUrl: String) -> UIViewController? {
        
        //Get the Storyboard
        let storyBoard = UIStoryboard(name: SingleImageView.storyboard, bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: SingleImageView.identifier)
        
        //Create VIPER files
        guard let view = viewController as? SingleImageView else {
            return nil
        }
        
        let interactor = SingleImageInteractor(imageUrl: imageUrl)
        let router = SingleImageRouter()
        let presenter = SingleImagePresenter()
        
        //Connect View
        view.presenter = presenter
        
        //Connect Presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        //Connect Interactor
        interactor.output = presenter
        
        //Connect Router
        router.viewController = viewController
        
        return viewController
    }
}
