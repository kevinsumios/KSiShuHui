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
    var id: Int16 = 0
    var historyChapter: Chapter? {
        get {
            return Bookmark.chapter(of: id)
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
        if let chapter = historyChapter {
            let historyItem = UIBarButtonItem(
                title: chapter.chapterTitle,
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
        if let chapter = Chapter.serialize(data[indexPath.row]) {
            cell.title = chapter.chapterTitle
            cell.explain = chapter.title
            cell.cover = chapter.cover
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "readBook", sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "readBook", let readController = segue.destination as? ReadBookController {
            readController.book = id
            if let selectedRow = tableView.indexPathForSelectedRow {
                readController.chapter = Chapter.serialize(data[selectedRow.row])
            } else {
                readController.chapter = historyChapter
            }
        }
    }
    
}
