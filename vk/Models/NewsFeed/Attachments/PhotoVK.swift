//
//  PhotoVK.swift
//  vk
//
//  Created by Alex on 02.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoVK: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var album_id: Int = 0
    @objc dynamic var owner_id: Int = 0
    var user_id: Int?
    var sizes: [SizePhotoVK] = []
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
