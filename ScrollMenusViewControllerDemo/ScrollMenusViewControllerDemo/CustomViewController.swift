//
//  CustomViewController.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/7.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    private let menus = ["关注的人", "谁关注我"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        let menuVC = ScrollMenuViewController.instance(
            type: .splitTheScreen,
            titleType: .text(titles: menus),
            superVC: self,
            frame: menuView.bounds
        )
        menuView.addSubview(menuVC.view)
        menuVC.dataSource = self
    }

    static func instance() -> CustomViewController {
        let storyB = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyB.instantiateViewController(withIdentifier: "CustomViewController") as! CustomViewController
        return vc
    }
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension CustomViewController: ScrollMenuViewControllerDataSource {
    
    func menu(viewController: UIViewController, index: Int) {
        if index % 2 == 0 {
            let view = ListView(frame: viewController.view.bounds)
            view.set(title: menus[index])
            viewController.view.addSubview(view)
        } else {
            let view = CustomImageView.init(frame: viewController.view.bounds)
            view.set(title: menus[index])
            viewController.view.addSubview(view)
        }
    }
}
