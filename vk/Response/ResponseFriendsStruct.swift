//
//  ResponseUserCount.swift
//  vk
//
//  Created by Alex on 30.07.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation

class ResponseFriendsStruct: Codable {
    var count: Int = 0;
    var items: [Friend] = []
}
