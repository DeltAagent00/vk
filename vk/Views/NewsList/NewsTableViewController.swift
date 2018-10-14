//
//  NewsTableViewController.swift
//  vk
//
//  Created by Alex on 17.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    var newsFeed: ResponseNewsFeedStruct?
    let vkService = VKRequestService()
    var cacheImageService: CacheImageService?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tableView = self.tableView {
            cacheImageService = CacheImageService(container: tableView)
        }
        
        vkService.createRequestGetNewsFeed(){ [weak self] response, err in
            self?.newsFeed = response
            self?.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let news = newsFeed {
            return news.items.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "newsFeedCell", for: indexPath) as? NewsTableViewCell,
           let newsItem = newsFeed?.items[indexPath.row] {
            let newsFeedOwner = ParseDataUtils.getOwnerNewsFeed(newsFeed: newsItem, users: newsFeed?.profiles ?? [], grops: newsFeed?.groups ?? [])
            cell.fill(newsFeed: newsItem, owner: newsFeedOwner, cacheImageService: cacheImageService, indexPath: indexPath)
            return cell
        }
        return UITableViewCell()
    }
}
