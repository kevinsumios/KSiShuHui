//
//  CategoryViewController.swift
//  Project
//
//  Created by Kevin Sum on 10/7/2017.
//  Copyright © 2017 Kevin iShuHui. All rights reserved.
//

import UIKit
import Alamofire
import FontAwesome_swift
import SwiftyJSON

class CategoryViewController: BaseViewController {
    
    var data: [JSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Layout
        let footer = UIView(frame: CGRect(origin: .zero, size: CGSize(width: self.tableView.frame.width, height: tabBarController?.tabBar.frame.height ?? 42)))
        footer.backgroundColor = .white
        self.tableView.tableFooterView = footer
        // Api
        let parameter: Parameters = ["ClassifyId":3, "Size":30]
        ApiHelper.shared.request(
            name: .getBook,
            parameters: parameter,
            success: { (json, response) in
                if let array = json.dictionary?["Return"]?.dictionary?["List"]?.array {
                    self.data = array
                    self.tableView.reloadData()
                }
        },
            failure: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookChapterTable", let table = segue.destination as? BookChapterTableController {
            if let selectedRow = tableView.indexPathForSelectedRow?.row {
                let book = data[selectedRow].dictionary
                table.cover = book?["FrontCover"]?.string
                table.name = book?["Title"]?.string
                table.author = book?["Author"]?.string
                table.status = book?["SerializedState"]?.string
                table.id = book?["Id"]?.int ?? 0
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryId", for: indexPath) as! CategoryTableViewCell
        if let book = data[indexPath.row].dictionary {
            let title = book["Title"]?.string ?? ""
            let author = book["Author"]?.string ?? ""
            cell.title = "\(title) \(author)"
            if let chapter = book["LastChapter"]?.dictionary?["Sort"]?.int {
                cell.chapter = "第\(chapter)話"
            }
            cell.explain = book["Explain"]?.string
            cell.cover = book["FrontCover"]?.string
        }
        return cell
    }
    
}
