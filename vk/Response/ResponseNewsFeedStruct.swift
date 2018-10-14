//
//  ResponseNewsFeedStruct.swift
//  vk
//
//  Created by Alex on 21.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation

class ResponseNewsFeedStruct: Codable {
    var items: [NewsFeed] = []
    var profiles: [Friend] = []
    var groups: [Group] = []
    var next_from: String?
}
