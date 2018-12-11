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
