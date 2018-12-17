//
//  ListView.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/17.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class ListView: UIView {
    
    private var tableView: UITableView = UITableView() {
        didSet {
            tableView.estimatedRowHeight = 60
            tableView.estimatedSectionFooterHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
        }
    }
    
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
        tableView = UITableView(frame: .zero, style: .plain)
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupLayout() {
        titleLabel.frame = CGRect(x: 0,
                                  y: 0,
                                  width: bounds.size.width,
                                  height: 44)
        tableView.frame = CGRect(x: 0,
                                 y: 44,
                                 width: bounds.size.width,
                                 height: bounds.size.height - 44)
    }
}

extension ListView {
    
    func set(title: String) {
        titleLabel.text = title
    }
}

extension ListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = titleLabel.text ?? "" + "\(indexPath.row)"
        return cell
    }
}

extension ListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
