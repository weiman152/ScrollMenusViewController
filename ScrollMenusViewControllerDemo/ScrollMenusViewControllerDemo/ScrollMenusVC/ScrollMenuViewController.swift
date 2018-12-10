//
//  ScrollMenuViewController.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/6.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

public enum ScrollMenuType {
    case splitTheScreen             // 平分屏幕
    case fixWidth(width: CGFloat)   // 固定宽度
    case autoWidth                  // 根据文字自适应宽度
}

public enum ScrollMenuTitleType {
    case text(titles: [String])          // 纯文本
    case leftImage(menus: [MenuMode])    // 左图右文
    case rightImage(menus: [MenuMode])   // 左文右图
}

public struct MenuMode {
    let title: String
    let normalImage: UIImage?
    let selectedImage: UIImage?
    
    public init(title: String) {
        self.title = title
        normalImage = nil
        selectedImage = nil
    }
    
    public init(title: String, normalImage: UIImage, selectedImage: UIImage) {
        self.title = title
        self.normalImage = normalImage
        self.selectedImage = selectedImage
    }
}

public class ScrollMenuViewController: UIViewController {

    // 默认平分屏幕
    private var type: ScrollMenuType = .splitTheScreen
    // 默认纯文本
    private var titleType: ScrollMenuTitleType = .text(titles: [])
    // 顶部菜单view
    private var menuView = MenusView()
    // 底部内容view
    private var collections: UICollectionView?
    /// 子VC的数组
    private var childVCs: [UIViewController] = []
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setup() {
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        setupMenus()
        setupCollections()
    }
    
    /// 创建滑动VC
    open class func instance(
        titleType: ScrollMenuTitleType,
        superVC: UIViewController,
        frame: CGRect = UIScreen.main.bounds,
        type: ScrollMenuType = .splitTheScreen
        ) -> ScrollMenuViewController {
        
        let vc = ScrollMenuViewController()
        vc.view.frame = frame
        vc.type = type
        vc.titleType = titleType
        superVC.addChildViewController(vc)
        vc.setup()
        return vc
    }

}

extension ScrollMenuViewController {
    
    private func setupMenus() {
        view.addSubview(menuView)
        menuView.frame = CGRect(x: 0,
                                y: 0,
                                width: view.bounds.size.width,
                                height: 44)
        menuView.setup(type: type, titleType: titleType)
    }
    
    private func setupCollections() {
        let flowLayout = UICollectionViewFlowLayout()
        collections = UICollectionView(frame: .zero,
                                       collectionViewLayout: flowLayout)
        view.addSubview(collections!)
    }
   
}
