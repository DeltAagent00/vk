//
//  ResponseProfilePhotosStruct.swift
//  vk
//
//  Created by Alex on 02.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation

class ResponseProfilePhotosStruct: Codable {
    var count: Int = 0;
    var items: [PhotoVK] = []
}
