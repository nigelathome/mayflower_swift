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
                
        let vc1 = ViewController()
        vc1.tabBarItem.title = "home"
        vc1.tabBarItem.image = UIImage(named: "icon.bundle/home@2x.png")
        vc1.tabBarItem.selectedImage = UIImage(named: "icon.bundle/home_selected@2x.png")
        vc1.view.backgroundColor = UIColor.red
        let navigationCtl: UINavigationController = UINavigationController(rootViewController: vc1)
        
        let vc2 = UIViewController()
        vc2.tabBarItem.title = "video"
        vc2.tabBarItem.image = UIImage(named: "icon.bundle/video@2x.png")
        vc2.tabBarItem.selectedImage = UIImage(named: "icon.bundle/video_selected@2x.png")
        vc2.view.backgroundColor = UIColor.orange
        
        let vc3 = UIViewController()
        vc3.tabBarItem.title = "like"
        vc3.tabBarItem.image = UIImage(named: "icon.bundle/like@2x.png")
        vc3.tabBarItem.selectedImage = UIImage(named: "icon.bundle/like_selected@2x.png")
        vc3.view.backgroundColor = UIColor.yellow
        
        let vc4 = UIViewController()
        vc4.tabBarItem.title = "page"
        vc4.tabBarItem.image = UIImage(named: "icon.bundle/page@2x.png")
        vc4.tabBarItem.selectedImage = UIImage(named: "icon.bundle/page_selected@2x.png")
        vc4.view.backgroundColor = UIColor.green
        
        let tabBarController: UITabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationCtl, vc2, vc3, vc4]
        tabBarController.delegate = self

        _window = UIWindow()
        _window?.rootViewController = tabBarController
        _window?.makeKeyAndVisible()
        
        return true
    }

}

extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("did select tab bar item!")
    }

}

