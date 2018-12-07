//
//  Menu.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/7.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class Menu: UIView {

    private lazy var contentView = UIView()
    private lazy var titleLabel: UILabel = {
        $0.text = ""
        $0.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        $0.font = font
        return $0
    }( UILabel() )
    private lazy var imageView: UIImageView = {
        return $0
    }( UIImageView() )
    
    // 默认左图右文
    private var type: ScrollMenuTitleType = .leftImage
    private var imageSize: CGSize = CGSize(width: 20, height: 20)
    private var font = UIFont.systemFont(ofSize: 16) {
        didSet {
            titleLabel.font = font
        }
    }
    
    // 图片和文字之间的距离
    private let spacing: CGFloat = 5
    
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
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        
    }
    
    private func setupLayout() {
        
        let menuWidth = bounds.size.width
        let menuHeight = bounds.size.height
        imageSize.height = imageSize.height < menuHeight ? imageSize.height : menuHeight
        imageSize.width = imageSize.width < menuWidth ? imageSize.width : menuWidth
        let titleSize = textSize(
            text: titleLabel.text ?? "",
            font: font,
            maxSize: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))
        )
        var titleWidth = titleSize.width
        if titleWidth > (menuWidth - imageSize.width - spacing) {
            titleWidth = menuWidth - imageSize.width - spacing
        }
        let contentWidth = imageSize.width + spacing + titleWidth
        
        switch type {
        case .leftImage: // 左图右文
            imageView.frame = CGRect(x: 0,
                                     y: center.y,
                                     width: imageSize.width,
                                     height: imageSize.height)
            titleLabel.frame = CGRect(x: imageSize.width + spacing,
                                      y: center.y,
                                      width: titleWidth,
                                      height: menuHeight)
        case .rightImage: // 左文右图
            titleLabel.frame = CGRect(x: 0,
                                      y: center.y,
                                      width: titleWidth,
                                      height: menuHeight)
            imageView.frame = CGRect(x: titleWidth + spacing,
                                     y: center.y,
                                     width: imageSize.width,
                                     height: imageSize.height)
        }
        
        contentView.frame = CGRect(x: 0,
                                   y: 0,
                                   width: contentWidth,
                                   height: menuHeight)
        contentView.center = center
    }
    
}

// MARK: - public
extension Menu {
    
    func set(type: ScrollMenuTitleType) {
        self.type = type
        setupLayout()
    }
    
    func set(color: UIColor) {
        titleLabel.textColor = color
    }
    
    func set(font: UIFont) {
        self.font = font
        setupLayout()
    }
    
    func set(title: String) {
        titleLabel.text = title
        setupLayout()
    }
    
    func set(imageSize: CGSize) {
        self.imageSize = imageSize
        setupLayout()
    }
}

// MARK: - private
extension Menu {
    
    private func textSize(text : String ,
                          font : UIFont ,
                          maxSize : CGSize) -> CGSize{
        return text.boundingRect(with: maxSize,
                                 options: [.usesLineFragmentOrigin],
                                 attributes: [NSAttributedStringKey.font : font],
                                 context: nil).size
    }
}
