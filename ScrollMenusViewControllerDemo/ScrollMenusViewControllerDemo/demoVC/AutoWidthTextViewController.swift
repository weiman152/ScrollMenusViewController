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
        
        let titles = ["北京", "广西壮族自治区", "上海", "海南省", "内蒙古自治区", "琼", "深圳"]
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
