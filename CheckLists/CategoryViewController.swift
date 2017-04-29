//
//  CategoryViewController.swift
//  CheckLists
//
//  Created by LinuxPlus on 4/24/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController, AddCategoryProtocol, UIWebViewDelegate{

    var categories:[CategoryItem]
    var deleteCategoryIndexPath: IndexPath?
    
    required init?(coder aDecoder: NSCoder) {
        categories = [CategoryItem]()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = true
        if let items = Utiles.loadCategoryItem(){
            categories = items
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
/*   Change tableView background
        let imageView : UIImageView
        imageView  = UIImageView(frame: tableView.bounds)
        imageView.image = #imageLiteral(resourceName: "background")
        imageView.contentMode = .scaleAspectFit
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = tableView.bounds
        imageView.addSubview(blurView)
        tableView.backgroundView = imageView
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.backgroundColor = .lightGray
*/
        
        if let items = Utiles.loadCategoryItem(){
            categories = items
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addCategorySegue"{
            if let navigationController = segue.destination as? UINavigationController{
                let controller = navigationController.topViewController as! AddCategoryViewController
                controller.delegate = self
            }
        }else if segue.identifier == "editCategorySegue"{
            if let navigationController = segue.destination as? UINavigationController{
                let controller = navigationController.topViewController as! AddCategoryViewController
                controller.delegate = self
                let index = tableView.indexPath(for: sender as! UITableViewCell)
                controller.editingCategory = categories[(index?.row)!]
            }
        }else if segue.identifier == "subCategorySegue"{
                let controller = segue.destination as! CheckListViewController
                let index = tableView.indexPath(for: sender as! UITableViewCell)
                controller.categoryIndex = index?.row
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
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryItemCell
        
        cell.detailed.text = String(categories[indexPath.row].items.count)
        cell.categoryName.text = categories[indexPath.row].title
        cell.addIcon.image = categories[indexPath.row].icon
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
         cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteCategoryIndexPath = indexPath
            let categoryItem = categories[indexPath.row]
            confirmDelete(categoryItem)
        }
    }
    
    func confirmDelete(_ categoryItem: CategoryItem){
        let alert = UIAlertController(title: "Delete Category", message: "Are you sure you want to permanently delete \(categoryItem.title)?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete",style: .destructive, handler: permanentlyDelete)
        let cancelAction = UIAlertAction(title: "Cancel",style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func permanentlyDelete(_ sender: UIAlertAction){
        if let indexPath = deleteCategoryIndexPath{
            tableView.beginUpdates()
            categories.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            tableView.endUpdates()
            Utiles.saveCategoryItem(for: categories)
        }
    }
    
   
    func addCategoryDone(_ controller: AddCategoryViewController, didFinishAdding item: CategoryItem ){
        let newRowIndex = categories.count
        categories.append(item)
        let indexPaths = IndexPath(item: newRowIndex, section: 0)
        tableView.insertRows(at: [indexPaths], with: UITableViewRowAnimation.automatic)
        dismiss(animated: true, completion: nil)
        Utiles.saveCategoryItem(for: categories)
    }
    
    func addCategoryDone(_ controller: AddCategoryViewController, didFinishEditing item: CategoryItem ){
        let newRowIndex = categories.index(of: item)
        let indexPaths = IndexPath(item: newRowIndex!, section: 0)
        tableView.reloadRows(at: [indexPaths], with: UITableViewRowAnimation.automatic)
        dismiss(animated: true, completion: nil)
        Utiles.saveCategoryItem(for: categories)
    }

    func addCategoryDidCancel(_ controller: AddCategoryViewController){
        dismiss(animated: true, completion: nil)
    }
    
    
}
