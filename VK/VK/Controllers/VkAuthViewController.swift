//
//  VKAuthViewController.swift
//  VK
//
//  Created by Антон Васильченко on 29.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import FirebaseDatabase

class VkAuthViewController: UIViewController, WKNavigationDelegate {
    
    
    let session = Session.instance
    let vkmethods = VKService()

    let date = Date()

    
    lazy var database = Database.database()
    lazy var ref: DatabaseReference = self.database.reference(withPath: "users")

    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        
        loadVkAuth()
        
    }
    func loadVkAuth () {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7552778"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
//            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "scope", value: "wall,friends,photos"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        guard let token = params["access_token"] else {return}
        guard let userId = params["user_id"] else {return}
        session.token = token
        session.userId = Int(userId)!
        print(session.userId)
        print(session.token)
        ref
            .child(String(session.userId))
            .setValue(["date": Date().shortDate, "time": Date().shortTime])
        performSegue(withIdentifier: "Home", sender: nil)
        
        
        decisionHandler(.allow)
    }
    
}
