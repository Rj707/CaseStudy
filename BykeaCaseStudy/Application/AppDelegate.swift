//
//  AppDelegate.swift
//  BykeaCaseStudy
//
//  Created by Hafiz Saad on 23/06/2021.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
                
        IQKeyboardManager.shared.enable = true

        return true
    }

}

