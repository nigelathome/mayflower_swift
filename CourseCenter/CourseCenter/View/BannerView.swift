//
//  BannerView.swift
//  CourseCenter
//
//  Created by nigelli on 2021/8/3.
//

import UIKit
import SnapKit

protocol BannerViewDataSource: AnyObject {
    func numberOfBanners(_ bannerView: BannerView) -> Int
    func viewForBanner(_ bannerView: BannerView, index: Int, convertView: UIView?) -> UIView
}

protocol BannerViewDelegate: AnyObject {
    func didSelectBanner(_ bannerView: BannerView, index: Int)
}

class BannerView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView
    var flowLayout: UICollectionViewFlowLayout
    var pageControl: UIPageControl
    
    weak var dataSource: BannerViewDataSource! {
        didSet {
            pageControl.numberOfPages = self.dataSource.numberOfBanners(self)
            collectionView.reloadData()
            DispatchQueue.main.async {
                self.collectionView.setContentOffset(CGPoint(x: self.collectionView.frame.width, y: 0), animated: false)
            }
        }
    }
    
    weak var delegate: BannerViewDelegate?
    
    var scrollInterval: Float = 0 {
        didSet {
            if self.scrollInterval > 0 {
                self.startAutoScroll()
            } else {
                self.stoptAutoScroll()
            }
        }
    }

    static var cellId = "cellId"
    var timer: Timer?
    static var convertViewTag = 10000
    
    override init(frame: CGRect) {
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), collectionViewLayout: flowLayout)
        pageControl = UIPageControl()
        
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: BannerView.cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(15)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let pagesNumber = dataSource.numberOfBanners(self)
        if pagesNumber == 1 {
            return 1
        } else {
            return pagesNumber + 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerView.cellId, for: indexPath)
        var index = indexPath.row
        
        let pageNumber = dataSource.numberOfBanners(self)
        if pageNumber > 1 {
            if indexPath.row == 0 {
                index = pageNumber - 1
            } else if indexPath.row == pageNumber + 1 {
                index = 0
            } else {
                index = indexPath.row - 1
            }
        }
        
        if let view = cell.contentView.viewWithTag(BannerView.convertViewTag) {
            let _ = dataSource.viewForBanner(self, index: index, convertView: view)
        } else {
            let newView = dataSource.viewForBanner(self, index: index, convertView: nil)
            newView.tag = BannerView.convertViewTag
            cell.contentView.addSubview(newView)
            newView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        
        return cell
    }
  
    func startAutoScroll() {
        guard scrollInterval > 0 && timer == nil else {
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(scrollInterval), target: self, selector: #selector(flipNextPage), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func stoptAutoScroll() {
        if let t = timer {
            t.invalidate()
            timer = nil
        }
    }
    
    @objc func flipNextPage() {
        guard let _ = superview, let _ = window else { //没有添加到view上或者已经从视图树中移除则直接返回
            return
        }
        
        let pagesNumber = dataSource.numberOfBanners(self)
        guard pagesNumber > 1 else {
            return
        }
        
        let curPageNumber = Int(round(collectionView.contentOffset.x / collectionView.frame.width)) //curPageNumber从0开始 0 1 2...
        let nextPageNumber = curPageNumber + 1
        collectionView.setContentOffset(CGPoint(x: collectionView.frame.width * CGFloat(nextPageNumber), y: 0), animated: true)
        
        //同步更新小点点
        if nextPageNumber >= pagesNumber + 1 {
            pageControl.currentPage = 0 //当前指向最后一个page 下一个page从第0个开始
        } else {
            pageControl.currentPage = nextPageNumber - 1 //pageControl的page从0开始 0 1 2...
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let pagesNumber = dataSource.numberOfBanners(self)
        let curPageNumber = Int(round(collectionView.contentOffset.x / collectionView.frame.width))
        if curPageNumber >= pagesNumber + 1 {
            collectionView.setContentOffset(CGPoint(x: collectionView.frame.width, y: 0), animated: false)
        }
    }
    
}
