//
//  AddIconViewController.swift
//  CheckLists
//
//  Created by LinuxPlus on 4/26/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class AddIconViewController: UITableViewController {

    var Category: CategoryItem!
    var objectType: String!
    var delegate: AddCategoryProtocol!
    
    var icons: [UIImage] = [#imageLiteral(resourceName: "No Icon"), #imageLiteral(resourceName: "Appointments"), #imageLiteral(resourceName: "Birthdays"), #imageLiteral(resourceName: "Chores"), #imageLiteral(resourceName: "Drinks"), #imageLiteral(resourceName: "Folder"), #imageLiteral(resourceName: "Groceries"), #imageLiteral(resourceName: "Inbox"), #imageLiteral(resourceName: "Photos"), #imageLiteral(resourceName: "Trips")]
    var iconNames:[String] = ["No icon", "Appointments", "Birthdays", "Chores", "Drinks", "Folder", "Groceries", "Inbox", "Photos", "Trips"]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "iconReturnSegue"{
            let controller = segue.destination as! AddCategoryViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            let icon = icons[(indexPath?.row)!]
            
            // return back the icon
            controller.categorySelectedIcon = icon
            controller.delegate = delegate
            // return back to previous TableView the same object.
            if objectType == "new item"{
                Category.icon = icon
                controller.newCategory = Category
            }else if objectType == "edit item"{
                Category.icon = icon
                controller.editingCategory = Category
            }
        }
    }
    
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
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let icon = icons[indexPath.row]
//        if let cat_item = Category{
//            cat_item.icon = icon
//        }
//    }
    
//    @IBAction func done(_ sender: Any) {
//        if let indexPath = tableView.indexPathForSelectedRow{
//            let icon = icons[indexPath.row]
//            if let cat_item = Category{
//                cat_item.icon = icon
//            }
//        }else{
//            let alert = Utiles.showAlert(alertTitle: "No Icon selected",alertMessage: "Please, select Icon first!", actionName: "OK")
//            present(alert, animated: true, completion: nil)
//        }
//        navigationController?.popViewController(animated: true)
//    }

}

