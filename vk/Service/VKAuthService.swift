//
//  VKAuthService.swift
//  vk
//
//  Created by Alex on 26.07.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import Alamofire

class VKAuthService : VKApiService {
    
    init() {
        super.init("https://oauth.vk.com/authorize")
    }
    
    func сreateAuthRequest() throws -> URLRequest {
        guard let url = URL(string: pathUrl) else {
            assertionFailure()
            throw UrlCreateError.wrongUrl
        }
        var parameters: Parameters {
            return [
                "client_id": idApi,
                "display": "mobile",
                "redirect_uri": "https://oauth.vk.com/blank.html",
                "scope": "friends,photos,groups,wall",
                "response_type": "token",
                "v": apiVersion
            ]
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        return try URLEncoding.default.encode(request, with: parameters)
    }
}

enum UrlCreateError : Error {
    case wrongUrl
}
