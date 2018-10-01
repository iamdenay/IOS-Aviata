
//
//  AppDelegate.swift
//  mvvm
//
//  Created by Atabay Ziyaden on 9/27/18.
//  Copyright © 2018 IcyFlame Studios. All rights reserved.
//

import UIKit
import Sugar

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds).then {
            $0.backgroundColor = .white
        }
        UIApplication.shared.statusBarStyle = .default

        let vc = TabBarViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }


}

