//
//  ChildListViewController.swift
//  ScrollMenusViewControllerDemo
//
//  Created by iOS on 2018/12/17.
//  Copyright © 2018 weiman. All rights reserved.
//

import UIKit

class ChildListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    static func instance(index: Int) -> ChildListViewController {
        let storyBoard = UIStoryboard.init(name: "ChildVC", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ChildListViewController") as! ChildListViewController
        vc.index = index
        return vc
    }

}

extension ChildListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "好好学习, menu = \(index), row = \(indexPath.row)"
        cell.imageView?.image = #imageLiteral(resourceName: "avatar")
        return cell
    }
}

extension ChildListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
