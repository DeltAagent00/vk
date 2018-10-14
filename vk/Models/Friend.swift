//
//  User.swift
//  vk
//
//  Created by Alex on 30.07.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import RealmSwift

class Friend: Object, Codable {
    @objc dynamic var name: String? = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var lastName: String? = ""
    @objc dynamic var photo: String? = ""
    @objc dynamic var online: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
        case online
    }
}
