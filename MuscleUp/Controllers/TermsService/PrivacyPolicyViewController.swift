//
//  PrivacyPolicyViewController.swift
//  MuscleUp
//
//  Created by Rohit Singh Dhakad on 20/06/21.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {

    
    @IBOutlet var webVw: WKWebView!
    @IBOutlet var lblTitle: UILabel!
    
  
    
    var strType = ""
    
    func loadUrl(strUrl:String){
        let url = NSURL(string: strUrl)
        let request = NSURLRequest(url: url! as URL)
        webVw.load(request as URLRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblTitle.text = strType
        
        switch strType {
        
        case "About Us":
            self.loadUrl(strUrl: "https://ambitious.in.net/Shubham/muscle/index.php/api/page/Terms")
        case "Privacy Policy":
            self.loadUrl(strUrl: "https://ambitious.in.net/Shubham/muscle/index.php/api/page/Privacy")
        default:
            self.loadUrl(strUrl: "https://ambitious.in.net/Shubham/muscle/index.php/api/page/FAQ")
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.setBgColor()
    }
    

    @IBAction func btnBackOnHeader(_ sender: Any) {
        self.onBackPressed()
    }
}


extension PrivacyPolicyViewController: WKNavigationDelegate{
    
    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
    }
}
