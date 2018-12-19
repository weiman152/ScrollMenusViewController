//
//  SplitScreenRightImageViewController.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/11.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class SplitScreenRightImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        let menu1 = MenuMode(title: "评论",
                             normalImage: #imageLiteral(resourceName: "menu_normal"),
                             selectedImage: #imageLiteral(resourceName: "menu_selected"))
        let menu2 = MenuMode(title: "沉默")
        let menu3 = MenuMode(title: "吃瓜",
                             normalImage: #imageLiteral(resourceName: "pay_normal"),
                             selectedImage: #imageLiteral(resourceName: "pay_selected"))
        let menu4 = MenuMode(title: "牧羊")
        let menus = [menu1, menu2, menu3, menu4]
        let frame = CGRect(x: 0,
                           y: 84,
                           width: view.bounds.size.width,
                           height: view.bounds.size.height - 84)
        let scrollVC = ScrollMenuViewController.instance(
            type: .splitTheScreen,
            titleType: .rightImage(menus: menus),
            superVC: self,
            frame: frame)
        view.addSubview(scrollVC.view)
        scrollVC.dataSource = self
    }

    static func instance() -> SplitScreenRightImageViewController {
        let storyBoard = UIStoryboard(name: "WM", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SplitScreenRightImageViewController") as! SplitScreenRightImageViewController
        return vc
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }

}

extension SplitScreenRightImageViewController: ScrollMenuViewControllerDataSource {
    
    func menu(viewController: UIViewController, index: Int) {
        var vc = UIViewController()
        switch index % 3 {
        case 0:
            vc = ChildListViewController.instance(index: index)
        case 1:
            vc = ChildImageViewController.instance(index: index)
        case 2:
            vc = ChildTextViewController.instance(index: index)
        default: break
        }
        
        viewController.addChildViewController(vc)
        viewController.view.addSubview(vc.view)
        vc.view.frame = viewController.view.bounds
    }
}
