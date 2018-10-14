//
//  CacheImage.swift
//  vk
//
//  Created by Alex on 28.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class CacheImageService: Operation {
    private let cacheTime: TimeInterval = 60 * 60 // in seconds
    private let container: DataReloadable
    private var images = [String: UIImage]()
    private static let pathName: String = {
       let pathName = "images"
        
        guard
            let cacheDir = FileManager.default.urls(for: .cachesDirectory,
                                                    in: .userDomainMask)
                .first
            else {
                return pathName
        }
        
        let url = cacheDir.appendingPathComponent(pathName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url,
                                                     withIntermediateDirectories: true,
                                                     attributes: nil)
        }
        return pathName
    }()
    
    init(container: DataReloadable) {
        self.container = container
    }
    
    private func getFilePath(url: String) -> String? {
        guard let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
            .first else { return nil }

        let hashName = String(describing: url.hashValue)
        return cacheDir.appendingPathComponent(CacheImageService.pathName + "/" + hashName).path
    }
    
    
    
    
    
    private func loadPhoto(indexPath: IndexPath, url: String) {
        Alamofire.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
            guard
                let data = response.data,
                let image = UIImage(data: data)
            else {
                return
            }
            
            self?.images[url] = image
            self?.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                self?.container.reloadRow(indexPath: indexPath)
            }
        }
    }
    
    private func saveImageToCache(url: String, image: UIImage) {
        guard
                let fileName = getFilePath(url: url)
            else {
                return
        }
        let data = UIImagePNGRepresentation(image)
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
            else {
                return nil
        }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard
            lifeTime <= cacheTime,
            let image = UIImage(contentsOfFile: fileName)
            else {
                return nil
        }
        
        images[url] = image
        return image
    }
    
    public func getPhoto(indexPath: IndexPath, url: String) -> UIImage? {
        if let photo = images[url] {
            return photo
        } else if let photo = getImageFromCache(url: url) {
            return photo
        } else {
            loadPhoto(indexPath: indexPath, url: url)
            return nil
        }
    }
}

