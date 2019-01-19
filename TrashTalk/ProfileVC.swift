//
//  SecondViewController.swift
//  TrashTalk
//
//  Created by Nathan Macfarlane on 1/18/19.
//  Copyright © 2019 Nathan Macfarlane. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!

    override func viewDidLoad() {
        self.nameLabel.text = ""
        self.usernameLabel.text = ""
        self.countLabel.text = ""
        super.viewDidLoad()
        profileImage.layer.cornerRadius = profileImage.frame.width / 2.0
        profileImage.layer.borderColor = UIColor(red: 228/255, green: 150/255, blue: 144/255, alpha: 1.0).cgColor
        profileImage.layer.borderWidth = 5.0

        Firestore.firestore().query(collection: "users", by: "id", with: "0APtjA0TWScwuuIN41VYSFg2gab2", of: User.self) { user in
            guard let user = user.first else { return }
            self.nameLabel.text = user.name
            self.usernameLabel.text = user.userName
            self.countLabel.text = "Trashes Picked Up: \(user.trashCount)"
        }
    }
    
    @IBOutlet weak var profileStats: UIImageView!
}

