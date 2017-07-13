//
//  BaseTableController.swift
//  Project
//
//  Created by Kevin Sum on 11/7/2017.
//  Copyright © 2017 Kevin iShuHui. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
import SDWebImage
import SwiftyJSON

class BaseTableController: BaseViewController {
    
    var data: [JSON] = []
    var index = 0
    var api: ApiHelper.Name?
    var parameter = Parameters()
    
    override func loadView() {
        api = nil
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Layout
        initLayout()
        // Initial api data
        loadData()
        // MJRefresh
        let refreshFooter = MJRefreshBackNormalFooter {
            self.loadData()
        }
        refreshFooter?.setTitle("拼命向上", for: .idle)
        refreshFooter?.setTitle("拼命向上", for: .pulling)
        refreshFooter?.setTitle("夠了", for: .willRefresh)
        refreshFooter?.setTitle("瘋狂旋轉中", for: .refreshing)
        refreshFooter?.setTitle("不要再拉了", for: .noMoreData)
        tableView.mj_footer = refreshFooter
    }
    
    func initLayout() {
        
    }
    
    func loadData() {
        if let name = api {
            ApiHelper.shared.request(
                name: name,
                parameters: parameter,
                success: { (json, response) in
                    if let result = json.dictionary?["Return"]?.dictionary {
                        if let array = result["List"]?.array {
                            self.data.append(contentsOf: array)
                            self.tableView.reloadData()
                            if let count = result["ListCount"]?.int, let size = result["PageSize"]?.int {
                                if (self.index+1)*size > count {
                                    self.tableView.mj_footer?.endRefreshingWithNoMoreData()
                                    return
                                } else {
                                    self.index += 1
                                }
                            }
                        }
                    }
                    self.tableView.mj_footer?.endRefreshing()
            },
                failure: { (error, response) in
                    self.tableView.mj_footer?.endRefreshing()
            })
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
}
