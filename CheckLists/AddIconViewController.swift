//
//  AddIconViewController.swift
//  CheckLists
//
//  Created by LinuxPlus on 4/26/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class AddIconViewController: UITableViewController {

    var categoryItem: CategoryItem!
    
    
    var icons: [UIImage] = [#imageLiteral(resourceName: "No Icon"), #imageLiteral(resourceName: "Appointments"), #imageLiteral(resourceName: "Birthdays"), #imageLiteral(resourceName: "Chores"), #imageLiteral(resourceName: "Drinks"), #imageLiteral(resourceName: "Folder"), #imageLiteral(resourceName: "Groceries"), #imageLiteral(resourceName: "Inbox"), #imageLiteral(resourceName: "Photos"), #imageLiteral(resourceName: "Trips")]
    
    var iconNames:[String] = ["No icon", "Appointments", "Birthdays", "Chores", "Drinks", "Folder", "Groceries", "Inbox", "Photos", "Trips"]
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iconCellIdentifier", for: indexPath) as! AddIconCell
        cell.icon.image = icons[indexPath.row]
        cell.iconName.text = iconNames[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let icon = icons[indexPath.row]
        if let cat_item = categoryItem{
            cat_item.icon = icon
        }
        navigationController?.popViewController(animated: true)
    }
    

}

