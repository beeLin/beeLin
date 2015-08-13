//
//  ViewController.swift
//  beeLin
//
//  Created by Sean Gilligan on 8/12/15.
//  Copyright (c) 2015 Sean Gilligan & Genevieve Primavera. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController, WKNavigationDelegate {

    var webView : WKWebView
    @IBOutlet var urlTextField : NSTextField?
    
    required init?(coder: NSCoder) {
        self.webView = WKWebView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 500, height: 500)))
        super.init(coder: coder)
        
        self.webView.navigationDelegate = self
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(webView, positioned: NSWindowOrderingMode.Below, relativeTo: urlTextField)
        let url = NSURL(string:"http://genevieveprimavera.com")
        let request = NSURLRequest(URL:url!)
        webView.loadRequest(request)
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

