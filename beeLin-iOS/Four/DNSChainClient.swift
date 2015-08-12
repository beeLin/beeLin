//
//  DNSChainClient.swift
//  Four
//
//  Created by Sean Gilligan on 7/11/15.
//  Copyright (c) 2015 Sean Gilligan. All rights reserved.
//

import Foundation

class DNSChainClient : NSObject  {
    let dotBitPattern : String = "^[^\\.]*\\.bit$"
    let dnsChainBase : String = "https://api.dnschain.net"
    
    // hostsname, e.g. "blockstream" (without .bit) to IP address string
    // TODO: Handle hostnames with subdomains, e.g. www.blockstream.bit
    func resolve(hostname: NSString) -> String {
        let keyVal : NSString = NSString(format: "d%@%@", "%2F", hostname)
        let urlString : NSString = NSString(format: "%@/v1/namecoin/key/%@", dnsChainBase, keyVal)
        let reqURL : NSURL = NSURL(string:urlString as String)!
        let request = NSMutableURLRequest(URL: reqURL)

        var response: NSURLResponse?
        var err: NSError?
        var dataVal = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &err)
        println(response)
        var jsonResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(dataVal!, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary
        println("Synchronous\(jsonResult)")
        var ipString : String = ""
        if let json = jsonResult as? NSDictionary {
            if let data = json["data"] as? NSDictionary {
                if let value = data["value"] as? NSDictionary {
                    let ip : AnyObject? = value["ip"]
                    if ip is String {
                        ipString = (ip as? String)!
                    } else if let ipArray = ip as? Array<String> {
                        ipString = ipArray[0]
                    }
                }
            }
        }
        return ipString
    }
    
    func createRequest(urlString : String) -> NSURLRequest {
        var url : NSURL
        
        if (isDotBit(urlString)) {
            let hostName : String = hostnameFromBitDomain(urlString)
            let ipAddr : String = resolve(hostName)
            let ipURLString : String = String(format: "http://%@", ipAddr)
            url = NSURL(string:ipURLString)!
        } else {
            url = NSURL(string:"http://" + urlString)!
        }
        
        var req : NSMutableURLRequest = NSMutableURLRequest(URL: url)
//        req.setValue(urlString, forHTTPHeaderField: "Host") // TODO: This doesn't work, is overwritten

        return req;
    }
    
    func isDomainResolvable(fqdn : String) -> Bool {
        return isDotBit(fqdn)
    }
    
    func hostnameFromBitDomain(fqdn : String) -> String {
        let range = Range(start: fqdn.startIndex, end: (advance(fqdn.endIndex, -4)))
        return fqdn.substringWithRange(range)
    }

    func isDotBit(fqdn: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", dotBitPattern)
        
        if test.evaluateWithObject(fqdn) {
            return true
        }
        return false
    }

}