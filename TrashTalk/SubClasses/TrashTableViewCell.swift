//
//  TrashTableViewCell.swift
//  TrashTalk
//
//  Created by Nathan Macfarlane on 1/19/19.
//  Copyright © 2019 Nathan Macfarlane. All rights reserved.
//

import UIKit

class TrashTableViewCell: UITableViewCell {
    let name = UILabel()
    let thumb = UIImageView()
    let place =  UILabel()

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var trashLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(place)
        place.frame =  CGRect(x:10, y:30, width: 20, height:20)
        place.center.y = self.center.y
        contentView.addSubview(name)
        name.frame = CGRect(x: 80, y:30, width: 100, height: 10)
        name.text = "HI I NEED TO FILL TEXT RIGHT NOW"
        name.sizeToFit()
        name.center.y = self.center.y
        contentView.addSubview(thumb)
        thumb.frame =  CGRect(x:30, y: 30, width: 30, height:30)
        thumb.center.y = self.center.y
        thumb.layer.cornerRadius = 15
        thumb.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
