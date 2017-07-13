//
//  TabBarController.swift
//  Project
//
//  Created by Kevin Sum on 11/7/2017.
//  Copyright © 2017 Kevin iShuHui. All rights reserved.
//

import UIKit
import FontAwesome_swift

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let item1 = tabBar.items?[0] {
            item1.image = UIImage.fontAwesomeIcon(name: .refresh, textColor: .gray, size: CGSize(width: 30, height: 30))
            item1.title = "本週新番"
        }
        if let item2 = tabBar.items?[1] {
            item2.image = UIImage.fontAwesomeIcon(name: .starO, textColor: .gray, size: CGSize(width: 30, height: 30))
            item2.selectedImage = UIImage.fontAwesomeIcon(name: .star, textColor: .gray, size: CGSize(width: 30, height: 30))
            item2.title = "漫畫列表"
        }
    }

}
