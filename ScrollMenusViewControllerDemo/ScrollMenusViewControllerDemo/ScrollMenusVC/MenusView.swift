//
//  MenusView.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/6.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class MenusView: UIView {
    
    private var type: ScrollMenuType = .splitTheScreen
    private var titleType: ScrollMenuTitleType = .text(titles: [])
    private var titles: [MenuMode] = []
    private var menus: [Menu] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupLayout()
    }
    
    private func setup() {
        
        switch titleType {
        case .text(let titles):
            for title in titles {
                let menu = MenuMode(title: title)
                self.titles.append(menu)
            }
            
        case .leftImage(let menus):
            titles = menus
            
        case .rightImage(let menus):
            titles = menus
        }
    }
    
    private func setupLayout() {
        
    }
    
}

extension MenusView {
    
    func setup(type: ScrollMenuType, titleType: ScrollMenuTitleType) {
        
    }
    
    func getTitles() -> [MenuMode] {
        return titles
    }
    
    func getMenus() -> [Menu] {
        return menus
    }
    
}

