//
//  CheckListItem.swift
//  CheckLists
//
//  Created by LinuxPlus on 4/19/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import Foundation
class CheckListItem: NSObject, NSCoding{
    
    var text: String
    var checked: Bool
    
    func toggleCheckMark(){
        self.checked = !checked
    }
    
    init(text: String, checked: Bool) {
        self.text = text
        self.checked = checked
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        let text = aDecoder.decodeObject(forKey: PropertyKeys.text) as? String
        let checked = aDecoder.decodeBool(forKey: PropertyKeys.checked)
        self.init(text: text!, checked: checked)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: PropertyKeys.text)
        aCoder.encode(checked, forKey: PropertyKeys.checked)
    }
}

struct PropertyKeys {
    static let text = "text"
    static let checked = "checked"
}


//    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
//    static let ArchiveUrl = DocumentsDirectory.appendingPathComponent("CheckListItem")
//    static let ArchiveUrl = categoryFilePath()

//
//func categoryFilePath() -> URL{
//    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//    return paths.appendingPathComponent("CheckListItem")
//}
