//
//  CheckListItemCell.swift
//  CheckLists
//
//  Created by LinuxPlus on 4/17/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class CheckListItemCell: UITableViewCell {

 
    @IBOutlet weak var checkItem: UILabel!
    @IBOutlet weak var cellRow: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        cellRow.text = ""
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
