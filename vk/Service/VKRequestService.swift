//
//  VKRequestService.swift
//  vk
//
//  Created by Alex on 28.07.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import Alamofire

class VKRequestService: VKApiService {
    
    func createRequestGetFriends(completionHandler: @escaping (Error?) -> Void) {
        var parameters: Parameters {
            return [
                "fields" : "photo_50"
            ]
        }
        
        сreateRequestAndGetResponse(parameters, "friends.get") { response, err in
            guard let data = response as? Data else {
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let responseFriends = try jsonDecoder.decode(ResponseFriends.self, from: data)
                
                RealmService.sharedInstance.printPathToDB()
                RealmService.sharedInstance.saveOrUpdate(responseFriends.response.items)
                
                DispatchQueue.main.async {
                    completionHandler(err)
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func createRequestGetGroups(completionHandler: @escaping (Error?) -> Void) {
        var parameters: Parameters {
            return [
                "fields" : "members_count",
                "extended" : 1
            ]
        }
        
        сreateRequestAndGetResponse(parameters, "groups.get") {response, err in
            guard let data = response as? Data else {
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let responseGroups = try jsonDecoder.decode(ResponseGroups.self, from: data)
                
                RealmService.sharedInstance.saveOrUpdate(responseGroups.response.items )
                
                DispatchQueue.main.async {
                    completionHandler(err)
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func createRequestGetAlbumPhotos(ownerId: Int, completionHandler: @escaping (ResponseProfilePhotosStruct?, Error?) -> Void) {
        var parameters: Parameters {
            return [
                "owner_id" : ownerId,
                "album_id" : "profile"
            ]
        }
        
        сreateRequestAndGetResponse(parameters, "photos.get") {response, err in
            guard let data = response as? Data else {
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let responseGroups = try jsonDecoder.decode(ResponseProfilePhotos.self, from: data)
                
                DispatchQueue.main.async {
                    completionHandler(responseGroups.response, err)
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func createRequestSearchGroup(_ term: String, completionHandler: @escaping (ResponseGroupsStruct?, Error?) -> Void) {
        var parameters: Parameters {
            return [
                "q" : term,
                "fields" : "members_count"
            ]
        }

        сreateRequestAndGetResponse(parameters, "groups.search") {response, err in
            guard let data = response as? Data else {
                return
            }

            do {
                let jsonDecoder = JSONDecoder()
                let responseGroups = try jsonDecoder.decode(ResponseGroupSearch.self, from: data)
                
                DispatchQueue.main.async {
                    completionHandler(responseGroups.response, err)
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func createRequestGetNewsFeed(completionHandler: @escaping (ResponseNewsFeedStruct?, Error?) -> Void) {
        var parameters: Parameters {
            return [
                "filters" : "post,wall_photo",
                "fields" : "members_count,photo_50,online"
            ]
        }
        
        сreateRequestAndGetResponse(parameters, "newsfeed.get") {response, err in
            guard let data = response as? Data else {
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let responseNewsFeed = try jsonDecoder.decode(ResponseNewsFeed.self, from: data)
                
                DispatchQueue.main.async {
                    completionHandler(responseNewsFeed.response, err)
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
