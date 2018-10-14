//
//  PostSource.swift
//  vk
//
//  Created by Alex on 21.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import RealmSwift

class PostSource: Object, Codable {
    @objc dynamic var type: String = ""
    @objc dynamic var platform: String? = ""
    @objc dynamic var data: String? = ""
}
