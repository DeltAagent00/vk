//
//  UICollectionViewExtentionDataReloadable.swift
//  vk
//
//  Created by Alex on 28.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView: DataReloadable {
    func reloadRow(indexPath: IndexPath) {
        reloadItems(at: [indexPath])
    }
}

