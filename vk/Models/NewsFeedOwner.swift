//
//  NewsFeedOwner.swift
//  vk
//
//  Created by Alex on 24.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation

class NewsFeedOwner {
    private var type: NewsFeedOwnerType
    private var user: Friend?
    private var group: Group?
    
    init(_ type: NewsFeedOwnerType, _ user: Friend?, _ group: Group?) {
        self.type = type
        self.user = user
        self.group = group
    }
    
    public func getId() -> Int {
        switch type {
            case .User:
                return user?.id ?? 0
            case .Group:
                return group?.id ?? 0
        }
    }
    
    public func getName() -> String {
        switch type {
        case .User:
            return "\(user?.name ?? "") \(user?.lastName ?? "")"
        case .Group:
            return group?.name ?? ""
        }
    }
    
    public func getUrlImage() -> String {
        switch type {
        case .User:
            return user?.photo ?? ""
        case .Group:
            return group?.photo ?? ""
        }
    }
    
    public func getType() -> NewsFeedOwnerType {
        return type
    }
    
    public func isOwnerUser() -> Bool {
        return type == NewsFeedOwnerType.User
    }
    
    public func isOwnerGroup() -> Bool {
        return type == NewsFeedOwnerType.Group
    }
}
