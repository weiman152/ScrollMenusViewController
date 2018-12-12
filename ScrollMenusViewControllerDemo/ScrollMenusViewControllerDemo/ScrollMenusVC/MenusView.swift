//
//  MenusView.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/6.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

protocol MenusViewDelegate: NSObjectProtocol {
    func menuClick(index: Int)
}

class MenusView: UIView {
    
    public var normalColor: UIColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    public var selectColor: UIColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    
    internal var delegate: MenusViewDelegate?
    
    private var scrollView = UIScrollView()
    private var menus: [Menu] = []
    private var currentIndex = 0
    
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
        addSubview(scrollView)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func setupLayout() {
        scrollView.frame = bounds
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
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        let height = bounds.size.height
        
        for (i, model) in models.enumerated() {
            let menu = Menu(frame: CGRect(
                x: CGFloat(i) * width,
                y: 0,
                width: width,
                height: height)
            )
            menu.index = i
            menu.set(title: model.title)
            if let image = model.normalImage {
                menu.set(image: image)
            }
            if let image = model.selectedImage, i == currentIndex {
                menu.set(image: image)
            }
            menus.append(menu)
            menu.delegate = self
            menu.set(color: i == 0 ? selectColor : normalColor)
            scrollView.addSubview(menu)
            menu.backgroundColor = UIColor.randomColor
        }
        scrollView.contentSize = CGSize(width: width * CGFloat(models.count),
                                        height: height)
    }
    
    private func addMenus(models: [MenuMode]) {
        
        menus.removeAll()
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        let height = bounds.size.height
        var tempWidth:CGFloat = 0
        for (i, model) in models.enumerated() {
            let menu = Menu(frame: .zero)
            menu.index = i
            let width = menu.getWidth(title: model.title)
            menu.frame = CGRect(x: tempWidth,
                                y: 0,
                                width: width,
                                height: height)
            menu.set(title: model.title)
            if let image = model.normalImage {
                menu.set(image: image)
            }
            if let image = model.selectedImage, i == currentIndex {
                menu.set(image: image)
            }
            menus.append(menu)
            menu.delegate = self
            menu.set(color: i == 0 ? selectColor : normalColor)
            scrollView.addSubview(menu)
            tempWidth += width
            menu.backgroundColor = UIColor.randomColor
        }
        scrollView.contentSize = CGSize(width: tempWidth,
                                        height: height)
    }
}

extension MenusView: MenuDelegate {
    
    func menuClick(index: Int) {
        
        for menu in menus {
            menu.set(color: menu.index == index ? selectColor : normalColor)
        }
        delegate?.menuClick(index: index)
    }
    
    func scrollTo(index: Int) {
        guard index < menus.count else {
            return
        }
        let menu = menus[index]
        let menuX = menu.frame.origin.x + menu.frame.size.width / 2.0
        let dis = menuX - center.x
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.scrollView.contentOffset = CGPoint(x: dis, y: 0)
            self?.layoutIfNeeded()
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


