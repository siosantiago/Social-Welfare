//
//  AppDelegate.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 02/07/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        return true
    }
    
    override init() {
        FirebaseApp.configure()
    }
    
    func logout() {
            let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialVC = mainStoryBoard.instantiateInitialViewController()
            window?.rootViewController = initialVC
            window?.makeKeyAndVisible()
    }
}


