//
//  SliderViewModel.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/6.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

protocol SliderViewModelDelegate: NSObjectProtocol {
    /// 添加新的VC
    func addChildVC(vc: UIViewController)
}

class SliderViewModel: NSObject {
    
    weak var delegate: SliderViewModelDelegate?
    
    private var collectionView: UICollectionView?
    private var count = 0
    private var childVCs: [UIViewController] = []

    func set(collectionView: UICollectionView, count: Int) {
        self.collectionView = collectionView
        self.count = count
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "BlankCell")
        // 创建vc
        childVCs.removeAll()
        for i in 1...count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor
            vc.view.tag = i
            childVCs.append(vc)
            delegate?.addChildVC(vc: vc)
        }
    }
}

extension SliderViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlankCell", for: indexPath)
        let vc = childVCs[indexPath.row]
        if !cell.subviews.contains(vc.view) {
            cell.addSubview(vc.view)
            vc.view.frame = cell.bounds
        }
        return cell
    }
}

extension SliderViewModel: UICollectionViewDelegate {
    
}


