//
//  Comments.swift
//  vk
//
//  Created by Alex on 21.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import RealmSwift

class Comments: Object, Codable {
    @objc dynamic var count: Int = 0
    @objc dynamic var groupsCanPost: Bool = false
    @objc dynamic var canPost: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case count
        case groupsCanPost = "groups_can_post"
        case canPost = "can_post"
    }
}
