//
//  FixWidthLeftImageViewController.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/11.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class FixWidthLeftImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
       
    }
    
    private func setup() {
        let menu1 = MenuMode(title: "好风",
                             normalImage: #imageLiteral(resourceName: "menu_normal"),
                             selectedImage: #imageLiteral(resourceName: "menu_selected"))
        let menu2 = MenuMode(title: "频")
        let menu3 = MenuMode(title: "借力",
                             normalImage: #imageLiteral(resourceName: "pay_normal"),
                             selectedImage: #imageLiteral(resourceName: "pay_selected"))
        let menu4 = MenuMode(title: "送我上青云")
        let menu5 = MenuMode(title: "风筝")
        let menus = [menu1, menu2, menu3, menu4, menu5]
        let frame = CGRect(x: 0,
                           y: 84,
                           width: view.bounds.size.width,
                           height: view.bounds.size.height - 84)
        let scrollVC = ScrollMenuViewController.instance(
            type: .fixWidth(width: 100),
            titleType: .leftImage(menus: menus),
            superVC: self,
            frame: frame)
        view.addSubview(scrollVC.view)
        scrollVC.dataSource = self
        scrollVC.set(menuBg: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), index: 0)
        scrollVC.set(menuBg: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), index: 1)
        scrollVC.set(menuBg: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), index: 2)
        scrollVC.set(menuBg: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), index: 3)
        scrollVC.set(menuBg: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), index: 4)
    }

    static func instance() -> FixWidthLeftImageViewController {
        let storyBoard = UIStoryboard(name: "WM", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FixWidthLeftImageViewController") as! FixWidthLeftImageViewController
        return vc
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }
}

extension FixWidthLeftImageViewController: ScrollMenuViewControllerDataSource {
    
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
