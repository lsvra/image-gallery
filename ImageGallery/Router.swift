//
//  BaseRouter.swift
//  ImageGallery
//
//  Created by Luís Vieira on 02/11/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import Foundation
import UIKit

let cache = NSCache<NSString, UIImage>()

class Router {
    
    static let shared: Router = Router()
    
    var baseViewController: BaseViewController?
    
    private init() {
        // Mandatory private init
    }

    func setBaseViewController(_ baseViewController: BaseViewController) {
        self.baseViewController = baseViewController
    }
    
    func openInitialViewController(){
        
        if let module = ImageListRouter.setupModule(delegate: self) {
            baseViewController?.setup(viewController: module)
        }
    }
    
    func openImageList(tagToSearch: String){
        
        //Dismiss any SinglePage view before making a new search
        baseViewController?.navigationController?.dismiss(animated: true, completion: nil)
        
        //TODO: find a better way to do the (Router -> ModuleRouter) communication
        if let vc = baseViewController?.children.first as? ImageListView {
            vc.presenter?.showImageList(tag: tagToSearch)
        }
    }
}

extension Router: RouterCommunicationProtocol {
    
    func openSingleImage(urlString: String) {
        
        if let module = SingleImageRouter.setupModule(imageUrl: urlString) {
            baseViewController?.push(viewController: module)
        }
    }
}
