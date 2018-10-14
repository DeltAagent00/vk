//
//  GroupTableViewController.swift
//  vk
//
//  Created by Alex on 06.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import UIKit
import FirebaseDatabase

class GroupTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar?
    
    let vkService = VKRequestService()
    var cacheImageService: CacheImageService?
    var groupArray: [Group] = []
    var indexAdded: Int = 0;
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tableView = self.tableView {
            cacheImageService = CacheImageService(container: tableView)
        }
        
        initSearchBar()
        runSearch("a")
    }
    
    func initSearchBar() {
        searchBar?.delegate = self
    }
    
    func runSearch(_ term: String) {
        vkService.createRequestSearchGroup(term) { [weak self] responseGroups, err in
            guard let items = responseGroups?.items else { return }
            self?.groupArray = items
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return groupArray.count > 0 ? 1 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groupArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableCellId", for: indexPath) as? UserTableViewCell {
            cell.fill(groupArray[indexPath.row], cacheImageService: cacheImageService, indexPath: indexPath)
            return cell
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let groupSelected = groupArray[indexPath.row]
        
        let dbLink = Database.database().reference()
        dbLink.child("Users/0").setValue(["addGroup" : groupSelected.toAnyObject])
//        dbLink.child("Users/0").updateChildValues([indexAdded : groupSelected.toAnyObject]) //not work
        indexAdded += 1
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            runSearch(searchText)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
