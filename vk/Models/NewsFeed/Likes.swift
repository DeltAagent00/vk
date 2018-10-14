//
//  Likes.swift
//  vk
//
//  Created by Alex on 21.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import RealmSwift

class Likes: Object, Codable {
    @objc dynamic var count: Int = 0
    @objc dynamic var userLikes: Int = 0
    @objc dynamic var canLike: Int = 0
    @objc dynamic var canPublish: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}
