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
    private let menus = ["推荐", "关注", "发现", "喜欢"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        
        let frame = CGRect(x: 0,
                           y: 20,
                           width: view.bounds.size.width,
                           height: view.bounds.size.height - 20)
        scrollVC = ScrollMenuViewController.instance(
            type: .splitTheScreen,
            titleType: .text(titles: menus),
            superVC: self,
            frame: frame)
        view.insertSubview(scrollVC.view, at: 0)
        scrollVC.dataSource = self
        scrollVC.menuBackgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
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
        label.text = menus[index]
        label.textAlignment = .center
        if index % 2 == 0 {
            label.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        } else {
            label.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        }
    }
}
