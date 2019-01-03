//
//  TwitterWebView.swift
//  EPHS
//
//  Created by Jennifer Nelson on 12/19/18.
//  Copyright © 2018 EPHS. All rights reserved.
//

import UIKit
import MapKit
import WebKit

class TwitterWebViewController: UIViewController {
    
    /*
     This is the ViewController that is switched to once a TableViewCell has been
     tapped.
     
     When a TableViewCell has been tapped, a segue will be performed and this URL variable
     will be set before the segue runs.
     
     When this view loads, the webView element will load the website.
     */
    
  
    @IBOutlet weak var webView: WKWebView!
    
    var url: String?
    var selectedLocation : TwitterInfoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("changed")
        let urlType = URL(string: url!)!
        webView.load(URLRequest(url: URL(string: self.url!)!))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
}

