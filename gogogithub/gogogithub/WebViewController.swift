//
//  WebViewController.swift
//  gogogithub
//
//  Created by Annie Ton-Nu on 4/6/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    let webView = WKWebView()
    
    var url: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: self.url) else { return }
        
            webView.frame = self.view.frame   //how big a where to live. frame is a CGRec (x,y,width,height)
        
            self.view.addSubview(self.webView)
        
            let urlRequest = URLRequest(url: url)
        
            self.webView.load(urlRequest)
        }
    


}
