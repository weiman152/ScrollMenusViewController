//
//  ChildImageViewController.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/17.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class ChildImageViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    private var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "索引: \(index)"
        
    }
    
    static func instance(index: Int) -> ChildImageViewController {
        let storyBoard = UIStoryboard(name: "ChildVC", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ChildImageViewController") as! ChildImageViewController
        vc.index = index
        return vc
    }

}
