//
//  Menu.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/7.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

protocol MenuDelegate: NSObjectProtocol {
    /// 按钮点击
    func menuClick(index: Int)
}

class Menu: UIView {

    weak var delegate:MenuDelegate?
    var index: Int = -1
    
    private lazy var contentView = UIView()
    private lazy var titleLabel: UILabel = {
        $0.text = ""
        $0.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        $0.font = font
        return $0
    }( UILabel() )
    private lazy var imageNormal: UIImageView = {
        return $0
    }( UIImageView() )
    private lazy var imageSelected: UIImageView = {
        return $0
    }( UIImageView() )
    
    // 默认左图右文
    private var type: ScrollMenuTitleType = .text(titles: [])
    private var imageSize: CGSize?
    private var font = UIFont.systemFont(ofSize: 16) {
        didSet {
            titleLabel.font = font
        }
    }
    // 图片和文字之间的距离
    private var spacing: CGFloat = 5
    
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
        contentView.addSubview(imageNormal)
        contentView.addSubview(imageSelected)
        
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(menuClick))
        addGestureRecognizer(tap)
    }
    
    private func setupLayout() {
        
        let menuWidth = bounds.size.width
        let menuHeight = bounds.size.height
        var imageWidth: CGFloat = 0
        var imageHeight: CGFloat = 0
        if let imageSize = imageSize {
            imageHeight = imageSize.height < menuHeight ? imageSize.height : menuHeight
            imageWidth = imageSize.width < menuWidth ? imageSize.width : menuWidth
        } else {
            spacing = 0
        }
       
        let titleSize = textSize(
            text: titleLabel.text ?? "",
            font: font,
            maxSize: CGSize(width: menuWidth, height: CGFloat(MAXFLOAT))
        )
        var titleWidth = titleSize.width
        if titleWidth > (menuWidth - imageWidth - spacing) {
            titleWidth = menuWidth - imageWidth - spacing
        }
        let contentWidth = imageWidth + spacing + titleWidth
        
        switch type {
        case .text: // 纯文本
            imageNormal.removeFromSuperview()
            imageSelected.removeFromSuperview()
            titleLabel.frame = CGRect(x: 0,
                                      y: 0,
                                      width: titleWidth,
                                      height: menuHeight)
        case .leftImage: // 左图右文
            let imageY = (menuHeight - imageHeight) / 2.0
            imageNormal.frame = CGRect(x: 0,
                                     y: imageY,
                                     width: imageWidth,
                                     height: imageHeight)
            imageSelected.frame = imageNormal.frame
            titleLabel.frame = CGRect(x: imageWidth + spacing,
                                      y: 0,
                                      width: titleWidth,
                                      height: menuHeight)
        case .rightImage: // 左文右图
            let imageY = (menuHeight - imageHeight) / 2.0
            titleLabel.frame = CGRect(x: 0,
                                      y: 0,
                                      width: titleWidth,
                                      height: menuHeight)
            imageNormal.frame = CGRect(x: titleWidth + spacing,
                                     y: imageY,
                                     width: imageWidth,
                                     height: imageHeight)
            imageSelected.frame = imageNormal.frame
        }
        
        contentView.frame = CGRect(x: (bounds.size.width - contentWidth) / 2.0,
                                   y: 0,
                                   width: contentWidth,
                                   height: menuHeight)
    }
}

// MARK: - public
extension Menu {
    
    func set(type: ScrollMenuTitleType) {
        self.type = type
        setupLayout()
    }
    
    func set(selected: Bool) {
        imageNormal.isHidden = selected
        imageSelected.isHidden = !selected
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
    
    func set(normal image: UIImage) {
        contentView.addSubview(imageNormal)
        imageNormal.image = image
        imageSize = image.size
        setupLayout()
    }
    
    func set(select image: UIImage) {
        contentView.addSubview(imageSelected)
        imageSelected.image = image
        imageSize = image.size
        setupLayout()
    }
    
    func set(imageSize: CGSize) {
        self.imageSize = imageSize
        setupLayout()
    }
    
    /// 对于自适应宽度的菜单，根据内容获取菜单宽度
    ///
    /// - Parameters:
    /// - title: 菜单显示文字
    /// - Returns: 菜单宽度
    func getWidth(title: String,
                  imageSize: CGSize = CGSize(width: 20, height: 20)) -> CGFloat {
        let maxSize = CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))
        let titleSize = textSize(text: title, font: font, maxSize: maxSize)
        let width = titleSize.width + spacing + imageSize.width
        return width
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
    
    @objc private func menuClick() {
        delegate?.menuClick(index: index)
    }
}
