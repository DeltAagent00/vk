//
//  DocVK.swift
//  vk
//
//  Created by Alex on 21.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import RealmSwift

class DocVK: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var title: String?
    @objc dynamic var size: Int = 0
    @objc dynamic var ext: String?
    @objc dynamic var url: String?
    @objc dynamic var date: Int = 0
    @objc dynamic var type: Int = 0
    @objc dynamic var accessKey: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case title
        case size
        case ext
        case url
        case date
        case type
        case accessKey = "access_key"
    }
}
