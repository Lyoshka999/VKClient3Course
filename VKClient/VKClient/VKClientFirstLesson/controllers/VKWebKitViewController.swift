//
//  VKWebKitViewController.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 15.06.2022.
//

import UIKit
import WebKit
import Alamofire

class VKWebKitViewController: UIViewController, WKNavigationDelegate {

    
    @IBOutlet weak var webview: WKWebView! {
        didSet{
            webview.navigationDelegate = self
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWebView()

    }

    
    
    private func configureWebView() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8194844"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        let request = URLRequest(url: urlComponents.url!)
        webview.load(request)
    }
    
    
    
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void)
    {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else {
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
        let token = params["access_token"]
        SessionMyApp.instance.token = token ?? "no token"
        decisionHandler(.cancel)
       
        alamofireGetFriends()
        alamofireGetPhotos()
        alamofireGetGroups()
    }
    
    
    
    private func alamofireGetFriends() {
        
        AF.request(
            "https://api.vk.com/method/friends.get?user_ids=8194844&fields=bdate&access_token=\(SessionMyApp.instance.token)&v=5.131"
        )
            .responseJSON { responce in
                print(responce.value)
                
            }
    }
    
    private func alamofireGetPhotos() {

        AF.request(
            "https://api.vk.com/method/photos.get?user_ids=8194844&fields=bdate&access_token=\(SessionMyApp.instance.token)&v=5.131"
        )
            .responseJSON { responce in
                print(responce.value)

            }
    }

    private func alamofireGetGroups() {

        AF.request(
            "https://api.vk.com/method/groups.get?user_ids=8194844&fields=bdate&access_token=\(SessionMyApp.instance.token)&v=5.131"
        )
            .responseJSON { responce in
                print(responce.value)

            }
    }

    
}
