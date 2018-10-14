//
//  LinkVK.swift
//  vk
//
//  Created by Alex on 21.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import RealmSwift

class LinkVK: Object, Codable {
    @objc dynamic var url: String?
    @objc dynamic var title: String?
    @objc dynamic var caption: String?
    @objc dynamic var description_: String?
    @objc dynamic var target: String?
    @objc dynamic var photo: PhotoVK?
    
    enum CodingKeys: String, CodingKey {
        case url
        case title
        case caption
        case description_ = "description"
        case target
        case photo
    }
}
