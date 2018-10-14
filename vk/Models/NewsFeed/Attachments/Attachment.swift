//
//  Attachment.swift
//  vk
//
//  Created by Alex on 21.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import RealmSwift

class Attachment: Object, Codable {
    @objc dynamic var type: String? = ""
    @objc dynamic var photo: PhotoVK?
    @objc dynamic var doc: DocVK?
    @objc dynamic var link: LinkVK?
}
