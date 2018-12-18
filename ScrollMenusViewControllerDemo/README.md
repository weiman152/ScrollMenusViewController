# ScrollMenusViewController

swift4 滑动菜单，每一个被滑动的页面都是一个VC。

如果想用每一个滑动页面是View的话，可以使用另一个sdk——ScrollMenusView，地址是：

https://github.com/weiman152/ScrollMenusView

效果图：<br>

![Alt text](https://github.com/weiman152/ScrollMenusViewController/blob/master/screenshot/a1.png) <br>

![Alt Text](https://github.com/weiman152/ScrollMenusViewController/blob/master/screenshot/a2.png)
<br>
![Alt Text](https://github.com/weiman152/ScrollMenusViewController/blob/master/screenshot/a3.png)
<br>
![Alt Text](https://github.com/weiman152/ScrollMenusViewController/blob/master/screenshot/a4.png)
<br>
![Alt Text](https://github.com/weiman152/ScrollMenusViewController/blob/master/screenshot/a5.png)
<br>
![Alt Text](https://github.com/weiman152/ScrollMenusViewController/blob/master/screenshot/a6.png)
<br>
![Alt Text](https://github.com/weiman152/ScrollMenusViewController/blob/master/screenshot/a7.png)
<br>
![Alt Text](https://github.com/weiman152/ScrollMenusViewController/blob/master/screenshot/a8.gif)
<br>
![Alt Text](https://github.com/weiman152/ScrollMenusViewController/blob/master/screenshot/a9.gif)
<br>
![Alt Text](https://github.com/weiman152/ScrollMenusViewController/blob/master/screenshot/a10.gif)
<br>
![Alt Text](https://github.com/weiman152/ScrollMenusViewController/blob/master/screenshot/a11.gif)
<br>
![Alt Text](https://github.com/weiman152/ScrollMenusViewController/blob/master/screenshot/a13.gif)
<br>
![Alt Text](https://github.com/weiman152/ScrollMenusViewController/blob/master/screenshot/gif.gif)


<br><br>
使用示例：

//
//  SplitScreenTextViewController.swift

//  ScrollMenusViewControllerDemo

//
//  Created by iOS on 2018/12/11.

//  Copyright © 2018 weiman. All rights reserved.

//

import UIKit

class SplitScreenTextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        let scrollMenuVC = ScrollMenuViewController.instance(
            type: .splitTheScreen,
            titleType: .text(titles: ["女装", "男装", "衣帽", "鞋袜"]),
            superVC: self,
            frame: CGRect(x: 0,
                          y: 84,
                          width: view.bounds.size.width,
                          height: view.bounds.size.height - 84)
        )
        view.addSubview(scrollMenuVC.view)
        scrollMenuVC.dataSource = self
    }
    
    static func instance() -> SplitScreenTextViewController {
        let storyBoard = UIStoryboard(name: "WM", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SplitScreenTextViewController") as! SplitScreenTextViewController
        return vc
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }

}

extension SplitScreenTextViewController: ScrollMenuViewControllerDataSource {
    
    func menu(viewController: UIViewController, index: Int) {
        
        var vc = UIViewController()
        switch index % 3 {
        case 0:
            vc = ChildListViewController.instance(index: index)
        case 1:
            vc = ChildImageViewController.instance(index: index)
        case 2:
            vc = ChildTextViewController.instance(index: index)
        default: break
        }
        
        viewController.addChildViewController(vc)
        viewController.view.addSubview(vc.view)
        vc.view.frame = viewController.view.bounds
    }
}

