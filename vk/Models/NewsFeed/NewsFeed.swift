//
//  NewsFeed.swift
//  vk
//
//  Created by Alex on 21.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import RealmSwift

class NewsFeed: Codable {
    var type: String = ""
    var sourceId: Int = 0
    var date: Int = 0
    var postId: Int = 0
    var postType: String?
    var text: String?
    var attachments: [Attachment]?
    var postSource: PostSource?
    var comments: Comments?
    var likes: Likes?
    var reposts: Reposts?
    var views: ViewsNewsFeed?
    //wall_photo
    var photos: WallPhotos?
    
    enum CodingKeys: String, CodingKey {
        case type
        case sourceId = "source_id"
        case date
        case postId = "post_id"
        case postType = "post_type"
        case text
        case attachments
        case postSource = "post_source"
        case comments
        case likes
        case reposts
        case views
        case photos
    }
}
