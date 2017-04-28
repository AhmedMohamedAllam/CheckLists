//
//  AddIconCell.swift
//  CheckLists
//
//  Created by LinuxPlus on 4/28/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class AddIconCell: UITableViewCell {
    
    @IBOutlet weak var iconName: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
