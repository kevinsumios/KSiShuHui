//
//  UpdateViewController.swift
//  Project
//
//  Created by Kevin Sum on 10/7/2017.
//  Copyright © 2017 Kevin iShuHui. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftDate
import SwiftyJSON

class UpdateViewController: BaseTableController {
    
    override func loadView() {
        super.loadView()
        api = ApiHelper.Name.getUpdate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshHeader = MJRefreshNormalHeader(refreshingBlock: {
            self.data = [JSON]()
            self.loadData()
        })
        tableView.mj_header = refreshHeader
        tableView.mj_footer = nil
        didFinishLoad = {
            self.data.sort(by: { (first, second) -> Bool in
                if let chapter1 = Chapter.serialize(first)?.refreshTime as Date?, let chapter2 = Chapter.serialize(second)?.refreshTime as Date? {
                    return chapter1.isAfter(date: chapter2, granularity: Calendar.Component.day)
                }
                return true
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.title = tabBarItem.title
    }

    override func loadData() {
        if let subscriptions = Subscription.mr_findAll() as? [Subscription] {
            var ids = [Int16]()
            for sub in subscriptions {
                ids.append(sub.bookId)
            }
            if ids.count > 0 {
                parameter = ["idJson":ids.description]
                super.loadData()
            } else {
                data = [JSON]()
                tableView.reloadData()
                tableView.mj_header?.endRefreshing()
                let alert = UIAlertController(title: "注意", message: "请先订阅漫画，再刷新", preferredStyle: .alert)
                let action = UIAlertAction(title: "好的", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "updateId", for: indexPath) as! UpdateTableViewCell
        if let book = data[indexPath.row].dictionary, let chapter = Chapter.serialize(data[indexPath.row]) {
            cell.title = "\(book["Book"]?.dictionary?["Title"]?.string ?? "") \(chapter.chapterTitle)"
            cell.desc = chapter.title
            cell.cover = chapter.cover
            if let update = chapter.refreshTime as Date? {
                if update.isToday {
                    cell.updateStr = "今天"
                } else if update.isBefore(date: Date(), granularity: .year) {
                    cell.updateStr = "\(update.year)"
                } else {
                    cell.updateStr = "\(update.month)-\(update.day)"
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let bookId = data[indexPath.row].dictionary?["BookId"]?.int16 {
                Subscription.subscribe(bookId: bookId, YesOrNo: false)
            }
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "readBook", let readController = segue.destination as? ReadBookController {
            if let selectedRow = tableView.indexPathForSelectedRow?.row, let id = data[selectedRow].dictionary?["BookId"]?.int16 {
                readController.book = id
                readController.chapter = Chapter.serialize(data[selectedRow])
            }
        }
    }

}
