//
//  ChildTextViewController.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/17.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class ChildTextViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "诗经·柏舟 \(index)"
        
    }
    
    static func instance(index: Int) -> ChildTextViewController {
        let storyBoard = UIStoryboard(name: "ChildVC", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ChildTextViewController") as! ChildTextViewController
        vc.index = index
        return vc
    }

}
