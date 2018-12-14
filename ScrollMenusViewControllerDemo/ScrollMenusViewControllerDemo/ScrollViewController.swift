//
//  ScrollViewController.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/7.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    
    private var scrollVC = ScrollMenuViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        let menus = ["推荐", "关注", "发现", "喜欢"]
        scrollVC = ScrollMenuViewController.instance(
            type: .splitTheScreen,
            titleType: .text(titles: menus),
            superVC: self)
        view.insertSubview(scrollVC.view, at: 0)
        scrollVC.dataSource = self
    }
    
    static func instance() -> ScrollViewController {
        let storyB = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyB.instantiateViewController(withIdentifier: "ScrollViewController") as! ScrollViewController
        return vc
    }
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension ScrollViewController: ScrollMenuViewControllerDataSource {
    
    func menu(viewController: UIViewController, index: Int) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        viewController.view.addSubview(label)
        label.center = viewController.view.center
        label.text = "哈哈哈哈哈 \(index)"
        label.backgroundColor = UIColor.yellow
    }
}
