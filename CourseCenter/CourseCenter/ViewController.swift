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
        homeViewController.tabBarItem.selectedImage = R.image.home_selected()?.withRenderingMode(.alwaysOriginal)
        homeViewController.tabBarItem.title = "home"
        homeViewController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.hexColor(0x333333)], for: .selected)
        
        let navigationHomeViewController = UINavigationController(rootViewController: homeViewController)
        self.addChild(navigationHomeViewController)
        
        let mineViewController = MineViewController()
        mineViewController.tabBarItem.image = R.image.mine()
        mineViewController.tabBarItem.selectedImage = R.image.mine_selected()?.withRenderingMode(.alwaysOriginal)
        mineViewController.tabBarItem.title = "mine"
        mineViewController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.hexColor(0x333333)], for: .selected)
        
        let navigationMineViewController = UINavigationController(rootViewController: mineViewController)
        self.addChild(navigationMineViewController)
       
    }

    @objc func didClickEntryButton() {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }

}

