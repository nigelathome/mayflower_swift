//
//  ViewController.swift
//  DailyNews
//
//  Created by nigelli on 2021/8/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label: UILabel = UILabel(frame: .zero)
        label.text = "Hello, Swift World!"
        label.sizeToFit()
        label.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        view.addSubview(label)
    }


}

