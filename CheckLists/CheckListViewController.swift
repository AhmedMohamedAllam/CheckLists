//
//  ViewController.swift
//  CheckLists
//
//  Created by LinuxPlus on 4/17/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController, addItemProtocol{

    var items: [CheckListItem]!
    var categories: [CategoryItem]!
    var categoryIndex:Int!
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = categories[categoryIndex].title
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemViewController"{
            if let navigationController = segue.destination as? UINavigationController{
                let controller = navigationController.topViewController! as! AddItemViewController
                controller.delegate = self
            }
        }else if segue.identifier == "EditViewController"{
            if let navigationController = segue.destination as? UINavigationController{
                let controller = navigationController.topViewController! as! AddItemViewController
                controller.delegate = self
                let index = tableView.indexPath(for: sender as! UITableViewCell)
                controller.addItemEditing = items[(index?.row)!]
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true
         categories = Utiles.loadCategoryItem()
         items = categories[categoryIndex].items
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = items.count
        return count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListsItem", for: indexPath) as! CheckListItemCell

        configureCheckMark(for: cell, at: indexPath)
        configureText(for: cell, at: indexPath)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CheckListItemCell
        let item = items[indexPath.row]
        item.toggleCheckMark()
        configureCheckMark(for: cell, at: indexPath)
        saveItemsInDictionary()
    }
   
    func configureCheckMark(for cell: CheckListItemCell, at indexPath: IndexPath){
        let item = items[indexPath.row]
        cell.checkItem.text = item.checked ?  "✅" : "🔘"
    }
    
    func configureText(for cell: CheckListItemCell, at indexPath: IndexPath){
        let item = items[indexPath.row]
        cell.cellRow.text = item.text
    }

    func addItem(_ item: CheckListItem) {
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
    }
    
    
    // Protocol Methods for add item
    
    func addItemViewControlerDidCancel(_ controler: AddItemViewController){
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewControler(_ controler: AddItemViewController, didFinishAdding item: CheckListItem){
        addItem(item)
        saveItemsInDictionary()
        dismiss(animated: true, completion: nil)
    }
    
     // Protocol Methods for edit item
    func addItemViewControler(_ controler: AddItemViewController, didFinishEditing item: CheckListItem){
        let newRowIndex = items.index(of: item)!
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        saveItemsInDictionary()
        dismiss(animated: true, completion: nil)
    }
    
    func saveItemsInDictionary(){
        //this line update categories item to be saved again
        categories[categoryIndex].items = items
        Utiles.saveCategoryItem(for: categories)
    }

    
//    func saveCheckListItemData(){
//        let data = NSMutableData()
//        let archiver = NSKeyedArchiver(forWritingWith: data)
//        archiver.encode(items, forKey: ")
//        archiver.finishEncoding()
//        data.write(to: CategoryKeys.ArchiveUrl, atomically: true)
//    }
//    
//
//    func loadCheckListItemData(){
//        
//        if let data = try? Data(contentsOf: CategoryKeys.ArchiveUrl){
//            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
//            if let unArchivedItems = unarchiver.decodeObject(forKey: String(describing: subCategory)){
//             items = unArchivedItems as! [CheckListItem]
//            }
//            unarchiver.finishDecoding()
//        }
//    }
 
    
    
}

