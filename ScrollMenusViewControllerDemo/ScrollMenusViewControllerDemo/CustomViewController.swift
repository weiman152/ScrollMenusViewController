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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        let menus = ["关注的人", "谁关注我"]
        let menuVC = ScrollMenuViewController.instance(menus: menus,
                                                       superVC: self,
                                                       frame: menuView.bounds)
        menuView.addSubview(menuVC.view)
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
