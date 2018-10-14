//
//  UserCollectionViewCell.swift
//  vk
//
//  Created by Alex on 25.07.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import UIKit
import Kingfisher

class UserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var avatarImageView: UIImageView?
    
    func fill(_ photoVK: PhotoVK, cacheImageService: CacheImageService?, indexPath: IndexPath) {
//        let imageUrl = URL(string: photoVK.sizes[0].url ?? "")
//        avatarImageView?.kf.setImage(with: imageUrl)
        if  let imageUrl = photoVK.sizes[0].url,
            let image = cacheImageService?.getPhoto(indexPath: indexPath, url: imageUrl) {
            avatarImageView?.image = image
        }
    }
}
