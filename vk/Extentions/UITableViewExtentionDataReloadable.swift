//
//  UITableViewExtentionDataReloadable.swift
//  vk
//
//  Created by Alex on 28.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import Foundation
import UIKit

extension UITableView: DataReloadable {
    func reloadRow(indexPath: IndexPath) {
        reloadRows(at: [indexPath], with: .none)
    }
}
