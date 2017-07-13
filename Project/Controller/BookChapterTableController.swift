//
//  BookChapterTableController.swift
//  Project
//
//  Created by Kevin Sum on 11/7/2017.
//  Copyright © 2017 Kevin iShuHui. All rights reserved.
//

import UIKit

class BookChapterTableController: BaseTableController {
    
    var cover: String?
    var name: String?
    var author: String?
    var status: String?
    var id = 0
    
    override func loadView() {
        super.loadView()
        api = ApiHelper.Name.getChapter
        if let nameStr = name {
            title = nameStr
        }
    }
    
    override func initLayout() {
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
    }
    
    override func loadData() {
        parameter = ["id":id, "PageIndex":index]
        super.loadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookChapterId", for: indexPath) as! BookChapterViewCell
        if let chapter = data[indexPath.row].dictionary {
            if let title = name, let chapterNo = chapter["ChapterNo"]?.int {
                let chapterType = chapter["ChapterType"]?.int ?? 0
                cell.title = "\(title) 第\(chapterNo)\(chapterType > 0 ? "卷" : "話")"
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
