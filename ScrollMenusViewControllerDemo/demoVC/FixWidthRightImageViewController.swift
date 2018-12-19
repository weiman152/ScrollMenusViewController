//
//  FixWidthRightImageViewController.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/11.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class FixWidthRightImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        let menu1 = MenuMode(title: "手机",
                             normalImage: #imageLiteral(resourceName: "menu_normal"),
                             selectedImage: #imageLiteral(resourceName: "menu_selected"))
        let menu2 = MenuMode(title: "ipad")
        let menu3 = MenuMode(title: "蓝牙耳机",
                             normalImage: #imageLiteral(resourceName: "pay_normal"),
                             selectedImage: #imageLiteral(resourceName: "pay_selected"))
        let menu4 = MenuMode(title: "超清晰音响")
        let menu5 = MenuMode(title: "mac")
        let menus = [menu1, menu2, menu3, menu4, menu5]
        let frame = CGRect(x: 0,
                           y: 84,
                           width: view.bounds.size.width,
                           height: view.bounds.size.height - 84)
        let scrollVC = ScrollMenuViewController.instance(
            type: .fixWidth(width: 120),
            titleType: .rightImage(menus: menus),
            superVC: self,
            frame: frame)
        view.addSubview(scrollVC.view)
        scrollVC.dataSource = self
        scrollVC.set(menuBg: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), index: 0)
        scrollVC.set(menuBg: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), index: 1)
        scrollVC.set(menuBg: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), index: 2)
        scrollVC.set(menuBg: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), index: 3)
        scrollVC.set(menuBg: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), index: 4)
    }

    static func instance() -> FixWidthRightImageViewController {
        let storyBoard = UIStoryboard(name: "WM", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FixWidthRightImageViewController") as! FixWidthRightImageViewController
        return vc
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }

}

extension FixWidthRightImageViewController: ScrollMenuViewControllerDataSource {
    
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
