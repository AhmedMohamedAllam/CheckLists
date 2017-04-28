//
//  CategoryItem.swift
//  CheckLists
//
//  Created by LinuxPlus on 4/24/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import Foundation
import UIKit

class CategoryItem: NSObject, NSCoding {
    var title: String = ""
    var icon:UIImage = #imageLiteral(resourceName: "No Icon")
    var items:[CheckListItem] = [CheckListItem]()
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: CategoryKeys.title) as! String
        icon = aDecoder.decodeObject(forKey: CategoryKeys.icon) as! UIImage
        items = aDecoder.decodeObject(forKey: CategoryKeys.items) as! [CheckListItem]
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: CategoryKeys.title)
        aCoder.encode(icon, forKey: CategoryKeys.icon)
        aCoder.encode(items, forKey: CategoryKeys.items)
    }
    
    
}

struct CategoryKeys {
    static let title = "title"
    static let icon = "icon"
    static let items = "items"
    static let categories = "categoryItems"
}




