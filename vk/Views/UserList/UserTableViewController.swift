//
//  UserTableViewController.swift
//  vk
//
//  Created by Alex on 25.07.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import UIKit
import RealmSwift

class UserTableViewController: UITableViewController {
    
    private let SegueIdentifier = "userListToCollection"
    
    let SectionHeaderHeight: CGFloat = 40
    let COUNT_SECTION = 2
    
    let vkService = VKRequestService()
    var cacheImageService: CacheImageService?
    var friendArray: Results<Friend>?
    var groupArray: Results<Group>?

    var selectedObject: Any?

    var tokenFriend: NotificationToken?
    var tokenGroup: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tableView = self.tableView {
            cacheImageService = CacheImageService(container: tableView)
        }
        
        vkService.createRequestGetFriends() { [weak self] err in
            self?.friendArray = RealmService.sharedInstance.getObjectsFriends()
            if ((self?.friendArray) != nil)  {
                self?.tokenFriend = self?.friendArray?.observe{[weak self] (changes) in
                    guard let tableView = self?.tableView else {
                        return
                    }
                    
                    switch(changes) {
                    case .initial(_):
                        tableView.reloadData()
                    case .update(_, let deletions, let insertions, let modifications):
                        tableView.beginUpdates()
                        tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                        tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                        tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                        tableView.endUpdates()
                    case .error(let error):
                        fatalError("\(error)")
                    }
                }
            }
        }
        
        vkService.createRequestGetGroups() { [weak self] err in
            self?.groupArray = RealmService.sharedInstance.getObjectsGroups()
            if ((self?.groupArray) != nil)  {
                self?.tokenGroup = self?.groupArray?.observe{[weak self] (changes) in
                    guard let tableView = self?.tableView else {
                        return
                    }
                    
                    switch(changes) {
                    case .initial(_):
                        tableView.reloadData()
                    case .update(_, let deletions, let insertions, let modifications):
                        tableView.beginUpdates()
                        tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 1)}), with: .automatic)
                        tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 1)}), with: .automatic)
                        tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 1)}), with: .automatic)
                        tableView.endUpdates()
                    case .error(let error):
                        fatalError("\(error)")
                    }
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return COUNT_SECTION
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
            
            case 0:
                return friendArray?.count ?? 0
            case 1:
                return groupArray?.count ?? 0
            default:
                return 0
            }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCellIdentifier", for: indexPath) as? UserTableViewCell {
                       
            switch indexPath.section {
                case 0:
                    if let friend = friendArray?[indexPath.row] {
                        cell.fill(friend, cacheImageService: cacheImageService, indexPath: indexPath)
                    }
                case 1:
                    if let group = groupArray?[indexPath.row] {
                        cell.fill(group, cacheImageService: cacheImageService, indexPath: indexPath)
                    }
                default: break
             
            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SectionHeaderHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
        view.backgroundColor = UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: SectionHeaderHeight))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        
        switch section {
        case 0:
            var count = 0
            if let countArray = friendArray?.count {
                count = countArray
            }
            label.text = "Friends" + ((count > 0) ? " (\(count))" : "")
        case 1:
            var count = 0
            if let countArray = groupArray?.count {
                count = countArray
            }
            label.text = "Groups" + ((count > 0) ? " (\(count))" : "")
        default:
            label.text = ""
        }
        view.addSubview(label)
        return view
    }

    // delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected section = \(indexPath.section) row = \(indexPath.row) ")
        
        switch indexPath.section {
        case 0:
            selectedObject = friendArray?[indexPath.row]
        case 1:
            selectedObject = groupArray?[indexPath.row]
        default:
            return
        }        
        performSegue(withIdentifier: SegueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier {
            if let destinationVC = segue.destination as? UserCollectionViewController {
                destinationVC.dataObject = selectedObject
            }
        }
    }
   
}
