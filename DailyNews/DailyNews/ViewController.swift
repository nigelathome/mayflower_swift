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
        
//        let label: UILabel = UILabel(frame: .zero)
//        label.text = "Hello, Swift World!"
//        label.sizeToFit()
//        label.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
//        view.addSubview(label)
//
//        let myView: MyView = MyView(frame: CGRect(x: 150, y: 200, width: 80, height:30))
//        myView.backgroundColor = UIColor.cyan
//        view.addSubview(myView)
//
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pushViewController(_:)))
//        myView.addGestureRecognizer(tap)
        
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func pushViewController(_ sender: AnyObject) {
        guard sender.isKind(of: UITapGestureRecognizer.self) else {
            return
        }
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.white
        vc.navigationItem.title = "二级页面"
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "右侧按钮", style: .plain, target: self, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell_id") else {
                return UITableViewCell(style: .subtitle, reuseIdentifier: "cell_id")
            }
            return cell
        }()
        
        cell.textLabel?.text = "标题"
        cell.detailTextLabel?.text = "副标题"
        cell.imageView?.image = UIImage(named: "icon.bundle/video@2x.png")
        return cell
        
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.white
        vc.navigationItem.title = String(format: "标题 section:%d row:%d", indexPath.section, indexPath.row)
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"右侧按钮", style: .plain, target: self, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

