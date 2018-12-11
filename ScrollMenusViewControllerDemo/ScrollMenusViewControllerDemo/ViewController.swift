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

    /// 自定义view
    @IBAction func customVC(_ sender: Any) {
        let vc = CustomViewController.instance()
        present(vc, animated: true)
    }
    
    /// 作为childvc使用
    @IBAction func scrollVC(_ sender: Any) {
        let vc = ScrollViewController.instance()
        present(vc, animated: true)
    }
    
    ///平分屏幕 纯文本
    @IBAction func splitScreenTextAction(_ sender: Any) {
        let vc = SplitScreenTextViewController.instance()
        present(vc, animated: true)
    }
    
    ///平分屏幕 左图右文
    @IBAction func splitScreenLeftImage(_ sender: Any) {
        let vc = SplitScreenLeftImageViewController.instance()
        present(vc, animated: true)
    }
    
    ///平分屏幕 左文右图
    @IBAction func splitScreenRightImage(_ sender: Any) {
        let vc = SplitScreenRightImageViewController.instance()
        present(vc, animated: true)
    }
    
    /// 固定宽度 纯文本
    @IBAction func fixWidthText(_ sender: Any) {
        let vc = FixWidthTextViewController.instance()
        present(vc, animated: true)
    }
    
    /// 固定宽度 左文右图
    @IBAction func fixWidthRightImage(_ sender: Any) {
        let vc = FixWidthRightImageViewController.instance()
        present(vc, animated: true)
    }
    
    /// 固定宽度 左图右文
    @IBAction func fixWidthLeftImage(_ sender: Any) {
        let vc = FixWidthLeftImageViewController.instance()
        present(vc, animated: true)
    }
    
    /// 自适应宽度 纯文本
    @IBAction func autoText(_ sender: Any) {
        let vc = AutoWidthTextViewController.instance()
        present(vc, animated: true)
    }
    
    /// 自适应宽度 左文右图
    @IBAction func autoRightImage(_ sender: Any) {
        let vc = AutoWidthRightImageViewController.instance()
        present(vc, animated: true)
    }
    
    /// 自适应宽度 左图右文
    @IBAction func autoLeftImage(_ sender: Any) {
        let vc = AutoWidthLeftImageViewController.instance()
        present(vc, animated: true)
    }
        
}

