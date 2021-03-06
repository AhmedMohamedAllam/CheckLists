//
//  AddCategoryViewController.swift
//  CheckLists
//
//  Created by LinuxPlus on 4/25/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class AddCategoryViewController: UITableViewController {
    
    @IBOutlet weak var addCategoryTextField: UITextField!
    @IBOutlet weak var addIconButton: UIButton!
    
    var delegate: AddCategoryProtocol!
    var editingCategory: CategoryItem!
    var newCategory = CategoryItem()
    
    
    override func viewWillAppear(_ animated: Bool) {
        addCategoryTextField.becomeFirstResponder()
        
        //set the icon to the item if it has one
        if let editingCategory  = editingCategory{
            if editingCategory.icon == #imageLiteral(resourceName: "No Icon"){
                addIconButton.setBackgroundImage(#imageLiteral(resourceName: "addIcon"), for: UIControlState.normal)
            }else{
                addIconButton.setBackgroundImage(editingCategory.icon, for: UIControlState.normal)
            }
            navigationItem.title = "Edit category"
            addCategoryTextField.placeholder = "Edit category"
            addCategoryTextField.text = editingCategory.title
        }else{
            if newCategory.icon == #imageLiteral(resourceName: "No Icon"){
                addIconButton.setBackgroundImage(#imageLiteral(resourceName: "addIcon"), for: UIControlState.normal)
            }else{
                addIconButton.setBackgroundImage(newCategory.icon, for: UIControlState.normal)
            }
        }

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddIconSegue"{
            let controller = segue.destination as! AddIconViewController
            if let item = editingCategory{
                controller.categoryItem = item
            }else{
                controller.categoryItem = newCategory
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate.addCategoryDidCancel(self)
    }
    
    @IBAction func done(_ sender: Any) {
        let textFieldData = addCategoryTextField.text!
        if textFieldData != ""{
            if let item = editingCategory{
                item.title = textFieldData
                delegate.addCategoryDone(self, didFinishEditing: item)
            }else{
                newCategory.title = textFieldData
                newCategory.items = [CheckListItem]()
                delegate.addCategoryDone(self, didFinishAdding: newCategory)
            }
        }else{
            let alert = Utiles.showAlert(alertTitle: "Title is required!", alertMessage: "Please, write the title first!", actionName: "OK")
            present(alert, animated: true, completion: nil)
        }
    }
}

protocol AddCategoryProtocol {
    func addCategoryDone(_ controller: AddCategoryViewController, didFinishAdding item: CategoryItem )
    func addCategoryDone(_ controller: AddCategoryViewController, didFinishEditing item: CategoryItem )
    func addCategoryDidCancel(_ controller: AddCategoryViewController)
}
