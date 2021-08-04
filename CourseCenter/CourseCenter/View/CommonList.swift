//
//  CommonList.swift
//  CourseCenter
//
//  Created by nigelli on 2021/8/3.
//

import UIKit

protocol CommonListDelegate: AnyObject {
    func didSelectItem<Item>(_ item:Item)
}

class CommonList<ItemType, CellType: CommonListCell<ItemType>>: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView
    
    override init(frame: CGRect) {
        tableView = UITableView(frame: .zero, style: .plain)
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var items: [ItemType]! = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    weak var delegate: CommonListDelegate?
    
    private func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CellType? = tableView.dequeueReusableCell(withIdentifier: "cellId") as? CellType
        if cell == nil {
            cell = CellType(style: .subtitle, reuseIdentifier: "cellId")
        }
        cell?.item = items[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
