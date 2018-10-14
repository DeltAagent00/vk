//
//  WallPhotos.swift
//  vk
//
//  Created by Alex on 21.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import RealmSwift

class WallPhotos: Object, Codable {
    @objc dynamic var count: Int = 0
    var items: [PhotoVK]?
}
