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
