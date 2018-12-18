//
//  SplitScreenLeftImageViewController.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/11.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class SplitScreenLeftImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        let menu1 = MenuMode(title: "太极",
                             normalImage: #imageLiteral(resourceName: "menu_normal"),
                             selectedImage: #imageLiteral(resourceName: "menu_selected"))
        let menu2 = MenuMode(title: "两仪")
        let menu3 = MenuMode(title: "四象",
                             normalImage: #imageLiteral(resourceName: "pay_normal"),
                             selectedImage: #imageLiteral(resourceName: "pay_selected"))
        let menus = [menu1, menu2, menu3]
        let frame = CGRect(x: 0,
                           y: 84,
                           width: view.bounds.size.width,
                           height: view.bounds.size.height - 84)
        let scrollVC = ScrollMenuViewController.instance(
            type: .splitTheScreen,
            titleType: .leftImage(menus: menus),
            superVC: self,
            frame: frame)
        view.addSubview(scrollVC.view)
    }
    
    static func instance() -> SplitScreenLeftImageViewController {
        let storyBoard = UIStoryboard(name: "WM", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SplitScreenLeftImageViewController") as! SplitScreenLeftImageViewController
        return vc
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }

}
