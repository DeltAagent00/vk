//
//  DataVK.swift
//  vk
//
//  Created by Alex on 26.07.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation


class UserVK {
    private var vkToken: String = ""
    private var userId: Int = 0
    
    static public let sharedInstance = UserVK();
    
    public var toAnyObject: Any {
        return [
            userId
        ]
    }
    
    func getToken() -> String {
        return vkToken
    }
    
    func getUserId() -> Int {
        return userId
    }
    
    func setToken(_ token: String) {
        self.vkToken = token
    }
    
    func setUserId(_ userId: Int) {
        self.userId = userId
    }
}

extension UserVK: CustomStringConvertible {
    public var description: String { return "@UserVK: userId = \(userId)\ntoken = \(self.vkToken)" }
}
