//
//  WebSourceViewController.swift
//  Interesnee-iOS
//
//  Created by Артем on 10.11.2022.
//

import UIKit
import WebKit

class WebSourceViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var sourceUrl: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = sourceUrl else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
