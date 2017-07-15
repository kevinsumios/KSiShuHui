//
//  BookChapterTableController.swift
//  Project
//
//  Created by Kevin Sum on 11/7/2017.
//  Copyright © 2017 Kevin iShuHui. All rights reserved.
//

import FontAwesome_swift
import SwiftyJSON
import UIKit

class BookChapterTableController: BaseTableController {
    
    var cover: String?
    var name: String?
    var author: String?
    var status: String?
    var explain: String?
    var id = 0
    var historyId: Int {
        get {
            return UserDefaults.standard.integer(forKey: "\(id)")
        }
    }
    var historyName: String? {
        get {
            return UserDefaults.standard.value(forKey: "\(historyId)") as? String
        }
    }
    
    override func loadView() {
        super.loadView()
        api = ApiHelper.Name.getChapter
        if let nameStr = name {
            title = nameStr
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showHistoryItem()
    }
    
    override func initLayout() {
        if let headerView = tableView.tableHeaderView as? BookChapterHeaderView {
            headerView.cover = cover
            headerView.title = "\(name ?? "") \(author ?? "")"
            headerView.explain = explain
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
    
    func showHistoryItem() {
        if historyId > 0 {
            let historyItem = UIBarButtonItem(
                title: historyName,
                style: .plain,
                target: self,
                action: #selector(goToHistory))
            self.navigationItem.setRightBarButton(historyItem, animated: true)
        }
    }
    
    func goToHistory() {
        performSegue(withIdentifier: "readBook", sender: nil)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookChapterId", for: indexPath) as! BookChapterViewCell
        if let chapter = data[indexPath.row].dictionary {
            if let chapterNo = chapter["ChapterNo"]?.int {
                let chapterType = chapter["ChapterType"]?.int ?? 0
                cell.title = "第\(chapterNo)\(chapterType > 0 ? "卷" : "話")"
            }
            cell.explain = chapter["Title"]?.string
            cell.cover = chapter["FrontCover"]?.string
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "readBook", sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "readBook", let readController = segue.destination as? ReadBookController {
            if let selectedRow = tableView.indexPathForSelectedRow {
                readController.id = data[selectedRow.row].dictionary?["Id"]?.int
                readController.book = id
                readController.name = (tableView.cellForRow(at: selectedRow) as! BookChapterViewCell).title
            } else {
                readController.id = historyId
                readController.book = id
                readController.name = historyName
            }
        }
    }
    
}
