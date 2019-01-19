//
//  TrashTableViewCell.swift
//  TrashTalk
//
//  Created by Nathan Macfarlane on 1/19/19.
//  Copyright © 2019 Nathan Macfarlane. All rights reserved.
//

import UIKit

class TrashTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var trashLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
