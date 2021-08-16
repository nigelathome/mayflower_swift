//
//  ViewController.swift
//  DailyNews
//
//  Created by nigelli on 2021/8/16.
//

import UIKit

class MyView: UIView {
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label: UILabel = UILabel(frame: .zero)
        label.text = "Hello, Swift World!"
        label.sizeToFit()
        label.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        view.addSubview(label)
        
        let myView: MyView = MyView(frame: CGRect(x: 150, y: 200, width: 80, height:30))
        myView.backgroundColor = UIColor.cyan
        view.addSubview(myView)
    }


}

