//
//  AppDelegate.swift
//  DailyNews
//
//  Created by nigelli on 2021/8/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var _window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        _window = UIWindow()
        _window?.rootViewController = ViewController()
        _window?.makeKeyAndVisible()
        
        return true
    }

}

