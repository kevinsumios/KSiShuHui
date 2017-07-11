//
//  BookChapterTableController.swift
//  Project
//
//  Created by Kevin Sum on 11/7/2017.
//  Copyright © 2017 Kevin iShuHui. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON

class BookChapterTableController: BaseViewController {
    
    var cover: String?
    var name: String?
    var author: String?
    var status: String?
    var data: [JSON] = []
    var id = 0
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Layout
        if let headerView = tableView.tableHeaderView as? BookChapterHeaderView {
            headerView.cover = cover
            headerView.title = name
            headerView.author = author
            if status == "未定义" {
                headerView.status = "連載中"
            } else {
                headerView.status = status
            }
        }
        self.tableView.tableFooterView = UIView(frame: .zero)
        // Api
        let parameter: Parameters = ["id":id, "PageIndex":index]
        ApiHelper.shared.request(
            name: .getChapter,
            parameters: parameter,
            success: { (json, response) in
                if let array = json.dictionary?["Return"]?.dictionary?["List"]?.array {
                    self.data = array
                    self.tableView.reloadData()
                }
        },
            failure: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookChapterId", for: indexPath) as! BookChapterViewCell
        if let chapter = data[indexPath.row].dictionary {
            if let title = name, let chapterNo = chapter["ChapterNo"]?.int {
                cell.title = "\(title) 第\(chapterNo)話"
            }
            cell.explain = chapter["Title"]?.string
            cell.cover = chapter["FrontCover"]?.string
        }
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "readBook", let readController = segue.destination as? ReadBookController {
            if let selectedRow = tableView.indexPathForSelectedRow?.row {
                readController.id = data[selectedRow].dictionary?["Id"]?.int
            }
        }
    }
    
}
