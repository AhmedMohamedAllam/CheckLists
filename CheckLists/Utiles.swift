//
//  Utiles.swift
//  CheckLists
//
//  Created by LinuxPlus on 4/27/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit
import Foundation

class Utiles{

    static func ArchiveUrl() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return paths.appendingPathComponent("CheckListsApp")
    }
    
    static func saveCategoryItem(for categories: [CategoryItem]){
        NSKeyedArchiver.archiveRootObject(categories, toFile: ArchiveUrl().path)
    }
    
    static func loadCategoryItem() -> [CategoryItem]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ArchiveUrl().path) as? [CategoryItem]
    }

    static func showAlert(alertTitle: String, alertMessage: String, actionName: String) -> UIAlertController {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: actionName, style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
    
}
