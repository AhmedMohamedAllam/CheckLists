//
//  AddItemViewController.swift
//  CheckLists
//
//  Created by LinuxPlus on 4/22/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {

    weak var delegate: addItemProtocol!
    weak var addItemEditing: CheckListItem!

    @IBOutlet weak var addItemTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addItemTextField.becomeFirstResponder()
        if let addItemEditing = addItemEditing{
            navigationItem.title = "Edit item"
            addItemTextField.placeholder = "Edit (\(addItemEditing.text)) title"
            addItemTextField.text = addItemEditing.text
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    @IBAction func cancel(_ sender: Any) {
        delegate.addItemViewControlerDidCancel(self)
    }
    
    
    @IBAction func done(_ sender: Any) {
        let textFieldData = addItemTextField.text!
        if textFieldData != ""{
            if let editingItem = addItemEditing{
                editingItem.text = textFieldData
                editingItem.checked = false
                delegate.addItemViewControler(self, didFinishEditing: editingItem)
            }else{
                let item = CheckListItem(text: textFieldData, checked: false)
                delegate.addItemViewControler(self, didFinishAdding: item)
            }
        }else{
            let alert = Utiles.showAlert(alertTitle: "Title is required", alertMessage: "Please, write the title first!", actionName: "OK")
            present(alert, animated: true, completion: nil)
        }
    }
   
}

protocol addItemProtocol : class
{
    func addItemViewControlerDidCancel(_ controler: AddItemViewController)
    func addItemViewControler(_ controler: AddItemViewController, didFinishAdding item: CheckListItem)
    func addItemViewControler(_ controler: AddItemViewController, didFinishEditing item: CheckListItem)

}




