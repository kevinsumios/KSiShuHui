//
//  ReadBookController.swift
//  KSiShuHui
//
//  Created by Kevin Sum on 12/7/2017.
//  Copyright © 2017 Kevin iShuHui. All rights reserved.
//

import FontAwesome_swift
import SwiftyJSON
import UIKit
import WebKit

class ReadBookController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!
    var book: Int?
    var name: String?
    var id: Int?
    var loadingView: UIStackView?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
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
        addLoadingView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnSwipe = false
    }
    
    func addLoadingView() {
        let image = UIImageView(image: UIImage.fontAwesomeIcon(name: .star, textColor: .black, size: CGSize(width: 100, height: 100)))
        let label = UILabel()
        label.text = "瘋狂加載中"
        loadingView = UIStackView(arrangedSubviews: [image, label])
        loadingView?.axis = .vertical
        if let loading = loadingView {
        view.addSubview(loading)
            view.addSubview(loading)
            loading.translatesAutoresizingMaskIntoConstraints = false
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }
    
    func removeLoadingView() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
    
    // MARK: - Webview delegate
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        removeLoadingView()
    }

}
