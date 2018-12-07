//
//  ScrollMenuViewController.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/6.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

public class ScrollMenuViewController: UIViewController {

    /// 子VC的数组
    private var childVCs: [UIViewController] = []
    private var menus: [String] = []
    private var collections: UICollectionView?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupLayout()
    }
    
    private func setup() {
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    }
    
    private func setupLayout() {
        
    }
    
    /// 创建滑动VC
    open class func instance(menus: [String],
                             superVC: UIViewController,
                             frame: CGRect = UIScreen.main.bounds) -> ScrollMenuViewController {
        let vc = ScrollMenuViewController()
        vc.menus = menus
        vc.view.frame = frame
        superVC.addChildViewController(vc)
        return vc
    }

}
