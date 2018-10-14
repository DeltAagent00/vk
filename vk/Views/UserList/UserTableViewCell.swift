//
//  UserTableViewCell.swift
//  vk
//
//  Created by Alex on 25.07.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView?
    @IBOutlet weak var nameUserTextView: UITextView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView?.circle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fill(_ friend: Friend, cacheImageService: CacheImageService?, indexPath: IndexPath) {
        nameUserTextView?.text = (friend.name ?? "") + " " + (friend.lastName ?? "")
//        let imageUrl = URL(string: friend.photo ?? "")
//        avatarImageView?.kf.setImage(with: imageUrl)
        if  let imageUrl = friend.photo,
            let image = cacheImageService?.getPhoto(indexPath: indexPath, url: imageUrl) {
            avatarImageView?.image = image
        }
    }
    
    func fill(_ group: Group, cacheImageService: CacheImageService?, indexPath: IndexPath) {
        var additionalText: String = "";
        
        if group.membersСount > 0 {
            additionalText =  " (" + "\(group.membersСount)" + ")"
        } else if let deactivated = group.deactivated {
            additionalText =  " (" + deactivated + ")"
        }
        
        nameUserTextView?.text = (group.name ?? "") + additionalText
//        let imageUrl = URL(string: group.photo ?? "")
//        avatarImageView?.kf.setImage(with: imageUrl)
        if  let imageUrl = group.photo,
            let image = cacheImageService?.getPhoto(indexPath: indexPath, url: imageUrl) {
            avatarImageView?.image = image
        }
    }

}
