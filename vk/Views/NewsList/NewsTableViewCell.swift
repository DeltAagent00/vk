//
//  NewsTableViewCell.swift
//  vk
//
//  Created by Alex on 17.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var userAvatarView: UIImageView?
    @IBOutlet weak var userNameView: UILabel?
    @IBOutlet weak var newsTextView: UILabel?
    @IBOutlet weak var newsImageView: UIImageView?
    @IBOutlet weak var likeView: UILabel?
    @IBOutlet weak var commentView: UILabel?
    @IBOutlet weak var repostView: UILabel?
    @IBOutlet weak var viewView: UILabel?
    
    func fill(newsFeed: NewsFeed, owner: NewsFeedOwner, cacheImageService: CacheImageService?, indexPath: IndexPath) {
        if let image = cacheImageService?.getPhoto(indexPath: indexPath, url: owner.getUrlImage()) {
            userAvatarView?.image = image
            userAvatarView?.circle()
        }
        
        userNameView?.text = owner.getName()
        
        newsTextView?.text = newsFeed.text ?? ""
        
        if let photos = newsFeed.photos, let items = photos.items {
            let url = URL(string: items[0].sizes[0].url ?? "")
            newsImageView?.kf.setImage(with: url)
            newsImageView?.isHidden = false
        } else {
            newsImageView?.isHidden = true
        }
        
        if let likes = newsFeed.likes {
            likeView?.text = "\(likes.count)"
        }
        if let comments = newsFeed.comments {
            commentView?.text = "\(comments.count)"
        }
        if let reposts = newsFeed.reposts {
            repostView?.text = "\(reposts.count)"
        }
        if let views = newsFeed.views {
            viewView?.text = "\(views.count)"
        }
        
//        reloadFrames()
    }
    
    let MARGIN_LEFT_RIGHT: CGFloat = 16
    let MARGIN_TOP_BOTTOM: CGFloat = 8
    let DIVIDED_SOCIAL_ITEM: CGFloat = 8
    
    func getLabelSize(text: String, font: UIFont, maxWidth: CGFloat) -> CGSize {
        
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = text.boundingRect(with: textBlock,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedStringKey.font: font],
                                     context: nil)
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        let size = CGSize(width: ceil(width), height: ceil(height))
        
        return size
    }
    
    func userAvatarFrame() {
        let iconSide = 40
        let iconSize = CGSize(width: iconSide, height: iconSide)
        let iconOrigin = CGPoint(x: MARGIN_LEFT_RIGHT, y: MARGIN_TOP_BOTTOM)
        userAvatarView?.frame = CGRect(origin: iconOrigin, size: iconSize)
    }
    
    func userNameFrame() {
        if let text = userNameView?.text, let font = userNameView?.font {
            let marginLeft = MARGIN_LEFT_RIGHT + (userAvatarView?.frame.width ?? 0) + MARGIN_LEFT_RIGHT / 2
            let maxWidth = bounds.width - marginLeft - MARGIN_LEFT_RIGHT
            let userNameSize = getLabelSize(text: text, font: font, maxWidth: maxWidth)
            let positionX = bounds.width - userNameSize.width - MARGIN_LEFT_RIGHT
            let userNameOrigin = CGPoint(x: positionX, y: MARGIN_TOP_BOTTOM)
            userNameView?.frame = CGRect(origin: userNameOrigin, size: userNameSize)
        }
    }
    
    func newsTextFrame() {
        if let text = newsTextView?.text, let font = userNameView?.font  {
            let maxWidth = bounds.width - MARGIN_LEFT_RIGHT * 2
            let newsTextSize = getLabelSize(text: text, font: font, maxWidth: maxWidth)
            let positionX = (bounds.width - newsTextSize.width) / 2
            
            let heightIcon = userAvatarView?.frame.height ?? 0;
            let heightUserName = userNameView?.frame.height ?? 0;
            
            var marginTop = MARGIN_TOP_BOTTOM;
            
            if heightIcon > heightUserName {
                marginTop = marginTop + (userAvatarView?.frame.maxY ?? 0)
            } else {
                marginTop += heightUserName + (userNameView?.frame.maxY ?? 0)
            }
            
            let positionY = marginTop
            let newsTextOrigin = CGPoint(x: positionX, y: positionY)
            newsTextView?.frame = CGRect(origin: newsTextOrigin, size: newsTextSize)
        }
    }
    
    func newsImageFrame() {
        let photoWidth = 343
        let photoHeight = 90
        let iconSize = CGSize(width: photoWidth, height: photoHeight)
        
        let positionX = MARGIN_LEFT_RIGHT
        let positionY = (newsTextView?.frame.maxY ?? 0) + MARGIN_TOP_BOTTOM
        
        let iconOrigin = CGPoint(x: positionX, y: positionY)
        userAvatarView?.frame = CGRect(origin: iconOrigin, size: iconSize)
    }
    
    func getMaxSocialItemSize() -> CGFloat {
        return (bounds.width - MARGIN_LEFT_RIGHT * 2) / 4 - 3 * DIVIDED_SOCIAL_ITEM
    }
    
    func likesFrame() {
        if let text = likeView?.text, let font = likeView?.font  {
            let maxWidth = getMaxSocialItemSize()
            let likesSize = getLabelSize(text: text, font: font, maxWidth: maxWidth)
            let positionX = MARGIN_LEFT_RIGHT
            let positionY = (newsImageView?.frame.maxY ?? 0) + MARGIN_TOP_BOTTOM
            let likesOrigin = CGPoint(x: positionX, y: positionY)
            likeView?.frame = CGRect(origin: likesOrigin, size: likesSize)
        }
    }
    
    func commentsFrame() {
        if let text = commentView?.text, let font = commentView?.font  {
            let maxWidth = getMaxSocialItemSize()
            let likesSize = getLabelSize(text: text, font: font, maxWidth: maxWidth)
            let positionX = (likeView?.frame.maxX ?? 0) + DIVIDED_SOCIAL_ITEM
            let positionY = (newsImageView?.frame.maxY ?? 0) + MARGIN_TOP_BOTTOM
            let likesOrigin = CGPoint(x: positionX, y: positionY)
            commentView?.frame = CGRect(origin: likesOrigin, size: likesSize)
        }
    }
    
    func repostsFrame() {
        if let text = repostView?.text, let font = repostView?.font  {
            let maxWidth = getMaxSocialItemSize()
            let likesSize = getLabelSize(text: text, font: font, maxWidth: maxWidth)
            let positionX = (commentView?.frame.maxX ?? 0) + DIVIDED_SOCIAL_ITEM
            let positionY = (newsImageView?.frame.maxY ?? 0) + MARGIN_TOP_BOTTOM
            let likesOrigin = CGPoint(x: positionX, y: positionY)
            repostView?.frame = CGRect(origin: likesOrigin, size: likesSize)
        }
    }
    
    func viewsFrame() {
        if let text = viewView?.text, let font = viewView?.font  {
            let maxWidth = getMaxSocialItemSize()
            let likesSize = getLabelSize(text: text, font: font, maxWidth: maxWidth)
            let positionX = (repostView?.frame.maxX ?? 0) + DIVIDED_SOCIAL_ITEM
            let positionY = (newsImageView?.frame.maxY ?? 0) + MARGIN_TOP_BOTTOM
            let likesOrigin = CGPoint(x: positionX, y: positionY)
            viewView?.frame = CGRect(origin: likesOrigin, size: likesSize)
        }
    }
    
    func reloadFrames() {
        userAvatarFrame()
        userNameFrame()
        newsTextFrame()
        newsImageFrame()
        likesFrame()
        commentsFrame()
        repostsFrame()
        viewsFrame()
    }
    
    override
    func layoutSubviews() {
        super.layoutSubviews()
        
//        reloadFrames()
    }
}
