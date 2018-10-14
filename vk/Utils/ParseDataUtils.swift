//
//  ParseDataUtils.swift
//  vk
//
//  Created by Alex on 24.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation

class ParseDataUtils {
    
    public static func getOwnerNewsFeed(newsFeed: NewsFeed, users: [Friend], grops: [Group]) -> NewsFeedOwner {
        let ownerId: Int = newsFeed.sourceId
        let type: NewsFeedOwnerType
        var user: Friend?
        var group: Group?
        
        if (ownerId >= 0) {
            type = .User
            user = users.first(where: { (user) -> Bool in
                return user.id == ownerId
            });
        } else {
            type = .Group
            let groupId = ownerId * -1
            group = grops.first(where: { (group) -> Bool in
                return groupId == group.id
            })
        }
        
        return NewsFeedOwner(type, user, group)
    }
}
