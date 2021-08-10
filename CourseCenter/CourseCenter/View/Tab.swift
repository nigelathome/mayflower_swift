//
//  Tab.swift
//  CourseCenter
//
//  Created by nigelli on 2021/8/4.
//

import UIKit
import SnapKit

class Tab: UIView {
    var items: [String]
    var itemButton: [UIButton]!
    var selectedItemButton: UIButton!
    
    var indicatiorView: UIView!
    
    var selectedColor: UIColor? {
        didSet {
            if let color = self.selectedColor {
                self.indicatiorView.backgroundColor = self.selectedColor
                itemButton .forEach { (btn) in
                    btn.setTitleColor(color, for: .selected)
                }
            } else {
                self.indicatiorView.backgroundColor = UIColor.hexColor(0xf8892e)
                itemButton .forEach { (btn) in
                    btn.setTitleColor(UIColor.hexColor(0xf8892e), for: .selected)
                }
            }
        }
    }
    
    var normalColor: UIColor?
    
    init?(items: [String]) {
        if items.count == 0 {
            return nil
        }
        
        self.items = items
        itemButton = []
        super.init(frame: .zero)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        var lastView: UIView?
        for index in 0..<items.count {
            let btn = UIButton(type: .custom)
            btn.setTitle(items[index], for: .normal)
            btn.setTitleColor(UIColor.hexColor(0x333333), for: .normal)
            btn.setTitleColor(UIColor.hexColor(0xf8892e), for: .selected)
            self.addSubview(btn)
            
            btn.snp.makeConstraints { (make) in
                if index == 0 {
                    make.left.equalToSuperview()
                } else {
                    make.left.equalTo(lastView!.snp.right)
                }
                make.top.bottom.equalToSuperview()
                if index == items.count - 1 {
                    make.right.equalToSuperview()
                }
            }
            
            lastView = btn
            btn.addTarget(self, action: #selector(didClickButton(sender:)), for: .touchUpInside)
            
        }
        
        indicatiorView = UIView()
        indicatiorView.backgroundColor = UIColor.hexColor(0xf8892e)
        self.addSubview(indicatiorView)
        indicatiorView.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.selectedItemButton)
            make.bottom.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(4)
        })
        
        
        
    }
    
    @objc func didClickButton(sender: UIButton) {
        guard sender != selectedItemButton else {
            return
        }
        
        selectedItemButton.isSelected = false
        sender.isSelected = true
        selectedItemButton = sender
        UIView.animate(withDuration: 3) {
            self.indicatiorView.snp.remakeConstraints { (make) in
                make.centerX.equalTo(self.selectedItemButton)
                make.bottom.equalToSuperview()
                make.width.equalTo(80)
                make.height.equalTo(4)
            }
        }
    }
}
