//
//  MenusView.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/6.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class MenusView: UIView {
    
//    private var type: ScrollMenuType = .splitTheScreen
//    private var titleType: ScrollMenuTitleType = .text(titles: [])
//    private var titles: [MenuMode] = []
    private var menus: [Menu] = []
    private var currentIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}

extension MenusView {
    
    func setup(type: ScrollMenuType, titleType: ScrollMenuTitleType) {
        
        switch type {
        case .splitTheScreen: // 平分屏幕
            splitScreen(titleType: titleType)
            
        case .fixWidth(let width): // 固定宽度
            fixWidth(titleType: titleType, width: width)
            
        case .autoWidth: // 根据文字自适应宽度
            autoWidth(titleType: titleType)
        }
    }
    
    func getMenus() -> [Menu] {
        return menus
    }
    
}

extension MenusView {
    
    private func splitScreen(titleType: ScrollMenuTitleType) {
        
        switch titleType {
        case .text(let titles):
            let width = bounds.size.width / CGFloat(titles.count)
            var models: [MenuMode] = []
            for title in titles {
                let model = MenuMode(title: title)
                models.append(model)
            }
            addMenus(models: models, width: width)
            
        case .leftImage(let menus):
            let width = bounds.size.width / CGFloat(menus.count)
            addMenus(models: menus, width: width)
            
        case .rightImage(let menus):
            let width = bounds.size.width / CGFloat(menus.count)
            addMenus(models: menus, width: width)
        }
    }
    
    private func fixWidth(titleType: ScrollMenuTitleType, width: CGFloat) {
        
        switch titleType {
        case .text(let titles):
            var models: [MenuMode] = []
            for title in titles {
                let menu = MenuMode(title: title)
                models.append(menu)
            }
            addMenus(models: models, width: width)
            
        case .leftImage(let menus):
            addMenus(models: menus, width: width)
            
        case .rightImage(let menus):
            addMenus(models: menus, width: width)
        }
    }
    
    private func autoWidth(titleType: ScrollMenuTitleType) {
        
        switch titleType {
        case .text(let titles):
            var models: [MenuMode] = []
            for title in titles {
                let menu = MenuMode(title: title)
                models.append(menu)
            }
            addMenus(models: models)
        case .leftImage(let menus):
            addMenus(models: menus)
            
        case .rightImage(let menus):
            addMenus(models: menus)
        }
    }
    
    private func addMenus(models: [MenuMode], width: CGFloat) {
        
        menus.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        let height = bounds.size.height
        
        for (i, model) in models.enumerated() {
            let menu = Menu(frame: CGRect(
                x: CGFloat(i) * width,
                y: 0,
                width: width,
                height: height)
            )
            menu.set(title: model.title)
            menu.set(index: i)
            if let image = model.normalImage {
                menu.set(image: image)
            }
            if let image = model.selectedImage, i == currentIndex {
                menu.set(image: image)
            }
            menus.append(menu)
            addSubview(menu)
            menu.backgroundColor = UIColor.randomColor
        }
    }
    
    private func addMenus(models: [MenuMode]) {
        
        menus.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        let height = bounds.size.height
        for (i, model) in models.enumerated() {
            let menu = Menu(frame: .zero)
            menu.set(title: model.title)
            menu.set(index: i)
            if let image = model.normalImage {
                menu.set(image: image)
            }
            if let image = model.selectedImage, i == currentIndex {
                menu.set(image: image)
            }
            let width = menu.getWidth(title: model.title)
            menu.frame = CGRect(x: CGFloat(i) * width,
                                y: 0,
                                width: width,
                                height: height)
            menus.append(menu)
            addSubview(menu)
        }
    }
}

extension UIColor {
    //返回随机颜色
    class var randomColor: UIColor {
     get {
       let red = CGFloat(arc4random()%256)/255.0
       let green = CGFloat(arc4random()%256)/255.0
       let blue = CGFloat(arc4random()%256)/255.0
       return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
     }
   }
}


