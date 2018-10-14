//
//  ViewController.swift
//  vk
//
//  Created by Alex on 12.07.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import UIKit
import WebKit
import FirebaseDatabase

class AuthViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView?
    @IBOutlet weak var infoLabel: UILabel?
   
    let vkService = VKAuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView?.navigationDelegate = self
        
        showAuthForm()
    }

    func showAuthForm() {
        do {
            let request = try vkService.сreateAuthRequest()
            webView?.load(request)
        }
        catch {
            assertionFailure(error.localizedDescription)
        }
    }
   
    func showAlert(text: String) {
        let alertController = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension AuthViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        if (error._code == -1009) {
            infoLabel?.text = "No Internet connection!"
            infoLabel?.isHidden = false
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard
            let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment
            else {
                decisionHandler(.allow)
                return
        }
        infoLabel?.isHidden = true
        
        let urlComponents = fragment.components(separatedBy: "&")
            .map{ $0.components(separatedBy: "=") }
        let token = urlComponents.first {$0.first == "access_token"}?.last
        let userId = Int(urlComponents.first {$0.first == "user_id"}?.last ?? "0")
        guard let accessToken = token else {
            assertionFailure("No token received!")
            decisionHandler(.allow)
            return
        }
        
        guard let userIdInt = userId else {
            assertionFailure("No user_id!")
            decisionHandler(.allow)
            return
        }
        
        UserVK.sharedInstance.setToken(token!);
        UserVK.sharedInstance.setUserId(userIdInt);
        
        let dbLink = Database.database().reference()
        dbLink.child("Users").setValue(UserVK.sharedInstance.toAnyObject)
     
        print("\(UserVK.sharedInstance)");
        
        decisionHandler(.cancel)
        performSegue(withIdentifier: "SuccessScene", sender: self)
    }
}

