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
    @IBOutlet var urlTextView : UITextField?
    
    let chainClient : DNSChainClient = DNSChainClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.loadWebView("blockstream.bit")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadWebView(fqdn: NSString) {
        webView?.delegate = self
        
        let req : NSURLRequest = chainClient.createRequest(fqdn as String)
        webView?.loadRequest(req)
        
        //webView?.loadHTMLString("Hello World!", baseURL: nil)
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        NSLog("succeeded")
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        NSLog("failed with %@", error)
    }
    
    @IBAction func goTapped(sender: UIButton) {
        var urlText : NSString? = urlTextView?.text
        
        if (urlText != nil) {
            loadWebView(urlText!)
        }
    }


}

