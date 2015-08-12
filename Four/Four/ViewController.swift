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
    @IBOutlet var constraintHeaderTop : NSLayoutConstraint?
    @IBOutlet var constraintHeaderBorderTop : NSLayoutConstraint?
    @IBOutlet var constraintUrlViewTop : NSLayoutConstraint?
    @IBOutlet var constraintGoButtonWidth : NSLayoutConstraint?
    
    let chainClient : DNSChainClient = DNSChainClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView!.hidden = true
        
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

    func resizeWebView() {
        self.view.layoutIfNeeded()
        self.constraintHeaderTop?.constant = -140
        self.constraintHeaderBorderTop?.constant = 70
        self.constraintUrlViewTop?.constant = 0
//      self.constraintGoButtonWidth?.constant = 0
        
        UIView.animateWithDuration(0.4, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil);
        
        self.webView?.hidden = false
    }
    
    @IBAction func goTapped(sender: UIButton) {
        var urlText : NSString? = urlTextView?.text
        
        if (urlText != nil) {
            resizeWebView()
            loadWebView(urlText!)
        }
    }


}

