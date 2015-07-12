//
//  ViewController.swift
//  Four
//
//  Created by Sean Gilligan on 7/11/15.
//  Copyright (c) 2015 Sean Gilligan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var webView : UIWebView?
    let chainClient : DNSChainClient = DNSChainClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loadWebView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadWebView() {
        webView?.delegate = self
        
        let fqdn : String = "blockstream.bit"
        let req : NSURLRequest = chainClient.createRequest(fqdn)
        webView?.loadRequest(req)
        
        //webView?.loadHTMLString("Hello World!", baseURL: nil)
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        NSLog("succeeded")
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        NSLog("failed with %@", error)
    }


}

