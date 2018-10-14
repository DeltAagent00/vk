//
//  RealmService.swift
//  vk
//
//  Created by Alex on 06.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    static public let sharedInstance = RealmService();
    
    init() {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.deleteAll()
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func printPathToDB() {
        do {
            let realm = try Realm()
//            print("--------------")
//            print(realm.configuration.fileURL)
//            print("--------------")
        } catch {
            print(error)
        }
    }
    
    func saveOrUpdate(_ objects: [Object]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(objects, update: true)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func getObjectsFriends() -> Results<Friend>? {
        do {
            let realm = try Realm()
            return realm.objects(Friend.self)
        } catch {
            print(error)
        }
        return nil
    }
    
    func getObjectsGroups() -> Results<Group>? {
        do {
            let realm = try Realm()
            return realm.objects(Group.self)
        } catch {
            print(error)
        }
        return nil
    }
}
