//
//  ViewController.swift
//  CourseCenter
//
//  Created by nigelli on 2021/8/1.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let entry = UIButton(type: .custom)
        entry.setTitle("click", for: .normal)
        entry.setTitleColor(.blue, for: .normal)
        entry.addTarget(self, action: #selector(didClickEntryButton), for: .touchUpInside)
        view.addSubview(entry)
        entry.snp.makeConstraints { (make) in
            make.left.top.equalTo(100)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }

    @objc func didClickEntryButton() {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }

}

