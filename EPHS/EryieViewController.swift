//
//  EryieViewController.swift
//  EPHS
//
//  Created by Jennifer Nelson on 12/19/18.
//  Copyright © 2018 EPHS. All rights reserved.
//





// This doesn't actually do anything except make the whole thing break.

import UIKit
import MapKit
import WebKit

class EryieViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var url:String?
    var selectedLocation : TwitterInfoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
