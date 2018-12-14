//
//  ScrollMenuViewController.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/6.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

public protocol ScrollMenuViewControllerDelegate: NSObjectProtocol {

    /// 菜单改变
    func menuDidChange(index: Int, viewController: UIViewController)
}

public protocol ScrollMenuViewControllerDataSource: NSObjectProtocol {
    /// 给菜单填充数据
    func menu(viewController: UIViewController, index: Int)
}

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
    
    public weak var delegate: ScrollMenuViewControllerDelegate?
    public weak var dataSource: ScrollMenuViewControllerDataSource?

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
        menuView.delegate = self
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
        sliderViewModel.delegate = self
        sliderViewModel.dataSource = self
        switch titleType {
        case .text(let titles):
            sliderViewModel.set(collectionView: collections!, count: titles.count)
        case .leftImage(let menus):
            sliderViewModel.set(collectionView: collections!, count: menus.count)
        case .rightImage(let menus):
            sliderViewModel.set(collectionView: collections!, count: menus.count)
        }
    }
    
    private func fixWidthScroll(width: CGFloat, offsetX: CGFloat) {
        guard let collection = collections else {
            return
        }
        //1. 获取屏幕中间的位置
        let centerX = menuView.center.x
        //2. 找出不用滑动的菜单索引
        let fixIndex = centerX / width
        //3. 找到当前选中的菜单索引
        let index = offsetX / collection.bounds.size.width
        
        //4. 计算scrollview滑动的偏移量并滑动
        if (index > fixIndex)&&((childVCs.count - Int(index)) > Int(fixIndex)) {
            menuView.scrollTo(index: Int(index))
        }
    }
    
    private func autoWidthScroll(offsetX: CGFloat) {
        guard let collection = collections else {
            return
        }
        //1. 找出屏幕的中间位置
        let centerX = menuView.center.x
        //2. 判断选中的menu的中心点是在屏幕中间点的左边还是右边，注意最左边和最右边的计算
        let menus = menuView.getMenus()
        let index = Int(offsetX / collection.bounds.size.width)
        let contentsize = menuView.getContentSize()
        let menu = menus[index]
        let menuCenterX = menu.frame.origin.x + (menu.frame.size.width / 2.0)
        if  (menuCenterX > centerX)&&(contentsize.width - menuCenterX > centerX) {
            menuView.scrollTo(index: Int(index))
        } else {
            if menuCenterX < centerX {
                menuView.scrollToLeft()
            }
            if contentsize.width - menuCenterX < centerX {
                menuView.scrollToRight()
            }
        }
    }
}

extension ScrollMenuViewController: SliderViewModelDelegate {
    
    func addChildVC(vc: UIViewController) {
        childVCs.append(vc)
        addChildViewController(vc)
    }
    
    func menuDidScroll(to index: Int) {
        menuView.menuClick(index: index)
    }
    
    func menuDidScroll(offSetX: CGFloat) {
        switch type {
        case .splitTheScreen: break
        case .fixWidth(let width):
            fixWidthScroll(width: width, offsetX: offSetX)
        case .autoWidth:
            autoWidthScroll(offsetX: offSetX)
        }
    }
}

extension ScrollMenuViewController: SliderViewModelDataSource {
    
    func menu(viewController: UIViewController, index: Int) {
        dataSource?.menu(viewController: viewController, index: index)
    }
}

extension ScrollMenuViewController: MenusViewDelegate {
    /// 按钮点击，同步滑动内容
    func menuClick(index: Int) {
        sliderViewModel.scrollTo(index: index)
    }
}
