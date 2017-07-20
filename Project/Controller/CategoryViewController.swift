//
//  CategoryViewController.swift
//  Project
//
//  Created by Kevin Sum on 10/7/2017.
//  Copyright © 2017 Kevin iShuHui. All rights reserved.
//

import UIKit

class CategoryViewController: BaseTableController {
    
    var categoryId = 0
    
    override func loadView() {
        super.loadView()
        api = ApiHelper.Name.getBook
        tableView.allowsSelectionDuringEditing = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.title = tabBarItem.title
    }
    
    override func loadData() {
        parameter = ["ClassifyId":categoryId, "PageIndex":index]
        super.loadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryId", for: indexPath) as! CategoryTableViewCell
        if let book = data[indexPath.row].dictionary {
            let title = book["Title"]?.string ?? ""
            let author = book["Author"]?.string ?? ""
            cell.title = "\(title) \(author)"
            if let chapter = book["LastChapter"]?.dictionary?["Sort"]?.int {
                cell.chapter = "第\(chapter)話"
            }
            cell.cover = book["FrontCover"]?.string
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .default, title: "訂閱") { (action, indexPath) in
            tableView.setEditing(false, animated: true)
        }
        action.backgroundColor = .orange
        return [action]
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookChapterTable", let table = segue.destination as? BookChapterTableController {
            if let selectedRow = tableView.indexPathForSelectedRow?.row {
                let book = data[selectedRow].dictionary
                table.cover = book?["FrontCover"]?.string
                table.name = book?["Title"]?.string
                table.author = book?["Author"]?.string
                table.status = book?["SerializedState"]?.string
                table.explain = book?["Explain"]?.string
                table.id = book?["Id"]?.int16 ?? 0
            }
        }
    }
    
}
