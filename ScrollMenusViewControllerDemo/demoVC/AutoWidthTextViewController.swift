//
//  AutoWidthTextViewController.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/11.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class AutoWidthTextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        
        let titles = ["北京", "广西壮族自治区", "上海", "海南省", "内蒙古自治区", "琼", "深圳", "湖南省", "湘", "宁夏回族自治区", "河南省", "西藏自治区", "武汉", "皖", "江苏省"]
        let scrollVC = ScrollMenuViewController.instance(
            type: .autoWidth,
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

    static func instance() -> AutoWidthTextViewController {
        let storyBoard = UIStoryboard(name: "WM", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AutoWidthTextViewController") as! AutoWidthTextViewController
        return vc
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }

}

extension AutoWidthTextViewController: ScrollMenuViewControllerDataSource {
    
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
