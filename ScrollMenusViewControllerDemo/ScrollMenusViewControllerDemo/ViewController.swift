//
//  ViewController.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/6.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func customVC(_ sender: Any) {
        let vc = CustomViewController.instance()
        present(vc, animated: true)
    }
    
    @IBAction func scrollVC(_ sender: Any) {
        let vc = ScrollViewController.instance()
        present(vc, animated: true)
    }
    
}

