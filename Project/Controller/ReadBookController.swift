//
//  ReadBookController.swift
//  KSiShuHui
//
//  Created by Kevin Sum on 12/7/2017.
//  Copyright © 2017 Kevin iShuHui. All rights reserved.
//

import SwiftyJSON
import UIKit
import WebKit

class ReadBookController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var book: Int?
    var name: String?
    var id: Int?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name
        if let record = id, let readUrl = ApiHelper.shared.url(forName: .readBook) {
            if let bookId = book {
                UserDefaults.standard.set(record, forKey: "\(bookId)")
                UserDefaults.standard.set(name, forKey: "\(record)")
                UserDefaults.standard.synchronize()
            }
            let myRequest = URLRequest(url: readUrl.appendingPathComponent("\(record).html"))
            webView.load(myRequest)
        }
        if let recognizer = navigationController?.barHideOnSwipeGestureRecognizer {
            webView.addGestureRecognizer(recognizer)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnSwipe = false
    }

}
