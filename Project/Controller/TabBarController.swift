//
//  TabBarController.swift
//  Project
//
//  Created by Kevin Sum on 11/7/2017.
//  Copyright © 2017 Kevin iShuHui. All rights reserved.
//

import UIKit
import FontAwesome_swift
import SwiftyJSON

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let categoryConfig = [
            [
                "title": "最近更新"
            ],
            [
                "id": 3,
                "title": "鼠繪漫畫"
            ],
            [
                "id": 4,
                "title": "熱血漫畫"
            ]
        ]
        var index = 0
        if let tabControllers = viewControllers {
            for tabController in tabControllers {
                if let category = tabController as? CategoryViewController {
                    category.tabBarItem.image = UIImage.fontAwesomeIcon(name: .starO, textColor: .gray, size: CGSize(width: 30, height: 30))
                    category.tabBarItem.selectedImage = UIImage.fontAwesomeIcon(name: .star, textColor: .gray, size: CGSize(width: 30, height: 30))
                    category.tabBarItem.title = categoryConfig[index]["title"] as? String
                    category.categoryId = categoryConfig[index]["id"] as? Int ?? 0
                    index += 1
                } else if let update = tabController as? UpdateViewController {
                    update.tabBarItem.image = UIImage.fontAwesomeIcon(name: .refresh, textColor: .gray, size: CGSize(width: 30, height: 30))
                    update.tabBarItem.title = categoryConfig[index]["title"] as? String
                    index += 1
                }
            }
        }
    }

}
