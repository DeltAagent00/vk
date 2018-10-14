//
//  UserUICollectionViewController.swift
//  vk
//
//  Created by Alex on 25.07.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import UIKit

class UserCollectionViewController: UICollectionViewController {
    var dataObject: Any?
    let vkService = VKRequestService()
    var cacheImageService: CacheImageService?
    private let reuseIdentifier = "userCollectionCellId"
    var photoVKArray: [PhotoVK] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let collectionView = self.collectionView {
            cacheImageService = CacheImageService(container: collectionView)
        }
        // Register cell classes
//        collectionView?.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        guard let dataFriend = dataObject as? Friend else {
            return
        }
        
        vkService.createRequestGetAlbumPhotos(ownerId: dataFriend.id) { [weak self] responseAlbumPhoto, err in
            guard let items = responseAlbumPhoto?.items else { return }
            self?.photoVKArray = items
            self?.collectionView?.reloadData()
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return photoVKArray.count > 0 ? 1 : 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoVKArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? UserCollectionViewCell {
            cell.fill(photoVKArray[indexPath.row], cacheImageService: cacheImageService, indexPath: indexPath)
            return cell
        }
        return UICollectionViewCell()
    }

    
}
