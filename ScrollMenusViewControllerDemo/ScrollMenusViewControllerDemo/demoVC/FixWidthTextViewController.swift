//
//  FixWidthTextViewController.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/11.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class FixWidthTextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        let width = view.bounds.size.width / 3.0
        let titles = ["诗", "西游记", "离骚", "水浒传", "红楼梦", "悲惨世界", "巴黎圣母院", "红与黑"]
        let scrollVC = ScrollMenuViewController.instance(
            type: .fixWidth(width: width),
            titleType: .text(titles: titles),
            superVC: self,
            frame: CGRect(x: 0,
                          y: 84,
                          width: view.bounds.size.width,
                          height: view.bounds.size.height - 84)
        )
        view.addSubview(scrollVC.view)
        scrollVC.dataSource = self
    }
    
    static func instance() -> FixWidthTextViewController {
        let storyBoard = UIStoryboard(name: "WM", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FixWidthTextViewController") as! FixWidthTextViewController
        return vc
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }

}

extension FixWidthTextViewController: ScrollMenuViewControllerDataSource {
    
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
