//
//  HomeViewController.swift
//  CourseCenter
//
//  Created by nigelli on 2021/8/3.
//

import UIKit
import Kingfisher

class HomeViewController: BaseViewController, BannerViewDataSource, CommonListDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bannerView = BannerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 180))
        bannerView.scrollInterval = 3
        bannerView.dataSource = self
        view.addSubview(bannerView)
        
        let productList = CommonList<Product, ProductCell>(frame: .zero)
        productList.items = MockData.createProducts()
        productList.delegate = self
        view.addSubview(productList)
        productList.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(bannerView.snp.bottom).offset(5)
        }
    }
    
    //实现BannerViewDataSource协议方法
    func numberOfBanners(_ bannerView: BannerView) -> Int {
        return MockData.createBanners().count
    }
    
    func viewForBanner(_ bannerView: BannerView, index: Int, convertView: UIView?) -> UIView {
        if let view = convertView as? UIImageView {
            view.kf.setImage(with: URL(string: MockData.createBanners()[index]))
            return view
        } else {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.kf.setImage(with: URL(string: MockData.createBanners()[index]))
            return imageView
        }
    }
    
    func didSelectItem<Item>(_ item: Item) {
        if item is Product {
            let detailViewController = DetailViewController()
            
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
}
