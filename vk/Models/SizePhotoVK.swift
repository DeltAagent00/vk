//
//  SizePhotoVK.swift
//  vk
//
//  Created by Alex on 02.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import RealmSwift

class SizePhotoVK: Object, Codable {
    @objc dynamic var type: String? = ""
    @objc dynamic var url: String? = ""
    @objc dynamic var width: Int = 0
    @objc dynamic var height: Int = 0
}
