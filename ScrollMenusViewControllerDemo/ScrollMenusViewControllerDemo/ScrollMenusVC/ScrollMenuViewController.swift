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
    private var menuView: MenusView!
    // 底部内容view
    private var collections: UICollectionView?
    private var sliderViewModel = SliderViewModel()
    /// 子VC的数组
    private var childVCs: [UIViewController] = []
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setup() {
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        setupMenus()
        setupCollections()
    }
    
    /// 创建滑动VC
    open class func instance(
        type: ScrollMenuType,
        titleType: ScrollMenuTitleType,
        superVC: UIViewController,
        frame: CGRect = UIScreen.main.bounds
        ) -> ScrollMenuViewController {
        
        let vc = ScrollMenuViewController()
        vc.type = type
        vc.titleType = titleType
        superVC.addChildViewController(vc)
        vc.view.frame = frame
        vc.setup()
        return vc
    }
}

extension ScrollMenuViewController {
    
    private func setupMenus() {
        menuView = MenusView(frame: CGRect(x: 0,
                                           y: 0,
                                           width: view.bounds.size.width,
                                           height: 44))
        view.addSubview(menuView)
        menuView.setup(type: type, titleType: titleType)
    }
    
    private func setupCollections() {
        let height = view.bounds.size.height - menuView.frame.size.height
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: view.bounds.size.width,
                                     height: height)
        flowLayout.minimumLineSpacing = 0
        let frame = CGRect(x: 0,
                           y: menuView.frame.size.height,
                           width: view.bounds.size.width,
                           height: height)
        collections = UICollectionView(frame: frame,
                                       collectionViewLayout: flowLayout)
        view.addSubview(collections!)
        collections?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        switch titleType {
        case .text(let titles):
            sliderViewModel.set(collectionView: collections!, count: titles.count)
        case .leftImage(let menus):
            sliderViewModel.set(collectionView: collections!, count: menus.count)
        case .rightImage(let menus):
            sliderViewModel.set(collectionView: collections!, count: menus.count)
        }
    }
   
}
