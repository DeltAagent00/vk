//
//  VKApiService.swift
//  vk
//
//  Created by Alex on 26.07.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import Alamofire

class VKApiService {
    let pathUrl: String
    let idApi = "6288159"
    let apiVersion = "5.80"
    
    convenience init() {
        self.init("https://api.vk.com/method")
    }
    
    init(_ url: String) {
        pathUrl = url
    }
    
    func сreateRequestAndGetResponse(_ parameters: Parameters, _ method: String, completionHandler: @escaping (Any?, Error?) -> Void) {
        guard var url = URL(string: pathUrl) else {
            return
        }
        
        url.appendPathComponent(method)
        
        var params = parameters
        
        params.updateValue(UserVK.sharedInstance.getUserId(), forKey: "userId")
        params.updateValue(UserVK.sharedInstance.getToken(), forKey: "access_token")
        params.updateValue(apiVersion, forKey: "v")

        Alamofire
            .request(url, method: .get, parameters: params)
            .responseData(queue: .global(qos: .default)) { repsonse in
                completionHandler(repsonse.value, nil)
            }
    }
}
