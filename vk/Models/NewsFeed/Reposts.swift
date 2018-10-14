//
//  Reposts.swift
//  vk
//
//  Created by Alex on 21.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import RealmSwift

class Reposts: Object, Codable {
    @objc dynamic var count: Int = 0
    @objc dynamic var userReposted: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}
