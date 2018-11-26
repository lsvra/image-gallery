//
//  AppDelegate.swift
//  ImageGallery
//
//  Created by Luís Vieira on 30/10/2018.
//  Copyright © 2018 Luís Vieira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        // Purge cache in case of memory warning.
        cache.removeAllObjects()
    }
}

