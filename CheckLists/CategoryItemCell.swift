//
//  CategoryItemCell.swift
//  CheckLists
//
//  Created by LinuxPlus on 4/24/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class CategoryItemCell: UITableViewCell {

    @IBOutlet weak var addIcon: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var detailed: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
