//
//  GTVideoViewController.swift
//  DailyNews
//
//  Created by nigelli on 2021/8/16.
//

import UIKit

class GTVideoViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem.title = "video"
        tabBarItem.image = UIImage(named: "icon.bundle/video@2x.png")
        tabBarItem.selectedImage = UIImage(named: "icon.bundle/video_selected@2x.png")
        view.backgroundColor = UIColor.orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

}
