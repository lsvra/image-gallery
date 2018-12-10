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

    weak var viewController: UIViewController?
    var delegate: RouterCommunicationProtocol?

    static func setupModule(delegate: RouterCommunicationProtocol) -> UIViewController? {
        
        //Get the Storyboard
        let storyBoard = UIStoryboard(name: ImageListView.storyboard, bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ImageListView.identifier)
        
        //Create VIPER files
        guard let view = viewController as? ImageListView else {
            return nil
        }
        
        let interactor = ImageListInteractor()
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
        
        //Connect Router
        router.viewController = viewController
        router.delegate = delegate
    
        return viewController
    }
    
    func openSingleImage(url: URL) {
        delegate?.openSingleImage(url: url)
    }
}
