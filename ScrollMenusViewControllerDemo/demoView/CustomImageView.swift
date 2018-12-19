//
//  CustomImageView.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/17.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class CustomImageView: UIView {
    
    private var imageView: UIImageView = {
        $0.image = #imageLiteral(resourceName: "iphoneBg2")
        $0.contentMode = .scaleAspectFit
        return $0
    }( UIImageView() )
    
    private var titleLabel: UILabel = {
        $0.textColor = .white
        $0.textAlignment = .center
        return $0
    }( UILabel() )

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
        addSubview(titleLabel)
        addSubview(imageView)
    }
    
    private func setupLayout() {
        titleLabel.frame = CGRect(x: 0,
                                  y: 0,
                                  width: bounds.size.width,
                                  height: 44)
        imageView.frame = CGRect(x: 0,
                                 y: 44,
                                 width: bounds.size.width,
                                 height: bounds.size.height - 44)
    }

}

extension CustomImageView {
    
    func set(title: String) {
        titleLabel.text = title
    }
}
