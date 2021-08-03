//
//  ViewController.swift
//  CourseCenter
//
//  Created by nigelli on 2021/8/1.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem.image = R.image.home()
        homeViewController.tabBarItem.selectedImage = R.image.home_selected()
        homeViewController.tabBarItem.title = "home"
        
        let navigationHomeViewController = UINavigationController(rootViewController: homeViewController)
        self.addChild(navigationHomeViewController)
        
        let mineViewController = MineViewController()
        mineViewController.tabBarItem.image = R.image.mine()
        mineViewController.tabBarItem.selectedImage = R.image.mine_selected()
        mineViewController.tabBarItem.title = "mine"
        
        let navigationMineViewController = UINavigationController(rootViewController: mineViewController)
        self.addChild(navigationMineViewController)
       
    }

    @objc func didClickEntryButton() {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }

}

