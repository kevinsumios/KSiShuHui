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
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
