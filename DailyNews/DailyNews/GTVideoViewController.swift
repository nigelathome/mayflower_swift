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
        
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell_1")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell_2")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell_3")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    

}

extension GTVideoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 120
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        if indexPath.item % 3 == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_1", for: indexPath)
            cell.backgroundColor = UIColor.green
        } else if indexPath.item % 3 == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_2", for: indexPath)
            cell.backgroundColor = UIColor.red
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_3", for: indexPath)
            cell.backgroundColor = UIColor.blue
        }
        return cell
    }
}

extension GTVideoViewController: UICollectionViewDelegate {
    
}

extension GTVideoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item % 3 == 0 {
            return CGSize(width: (view.frame.size.width - 10) / 2, height: 70)
        } else if indexPath.item % 3 == 1 {
            return CGSize(width: (view.frame.size.width - 10) / 2, height: 100)
        } else {
            return CGSize(width: view.frame.size.width, height: 130)
        }
        
    }
}
