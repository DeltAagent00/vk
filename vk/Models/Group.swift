//
//  Group.swift
//  vk
//
//  Created by Alex on 01.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import RealmSwift

class Group: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var photo: String?
    @objc dynamic var membersСount: Int = 0
    @objc dynamic var deactivated: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_50"
        case membersСount = "members_count"
        case deactivated
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.photo = try container.decode(String.self, forKey: .photo)
        
        do {
            self.membersСount = try container.decode(Int.self, forKey: .membersСount)
        } catch {
        }
        
        do {
            self.deactivated = try container.decode(String.self, forKey: .deactivated)
        } catch {
        }
    }
    
    public var toAnyObject: Any {
        return [
            id
        ]
    }
}
