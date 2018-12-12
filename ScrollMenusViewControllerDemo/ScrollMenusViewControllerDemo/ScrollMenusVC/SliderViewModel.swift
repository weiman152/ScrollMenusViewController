//
//  SliderViewModel.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/6.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class SliderViewModel: NSObject {
    
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
    }
}

extension SliderViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlankCell", for: indexPath)
        let vc = UIViewController()
        vc.view.frame = cell.bounds
        cell.addSubview(vc.view)
        childVCs.append(vc)
        return cell
    }
}

extension SliderViewModel: UICollectionViewDelegate {
    
}


