//
//  SecondViewController.swift
//  TrashTalk
//
//  Created by Nathan Macfarlane on 1/18/19.
//  Copyright © 2019 Nathan Macfarlane. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = ""
        self.countLabel.text = ""
        self.profileImage.image = nil
        indicator = UIActivityIndicatorView(style: .gray)
        indicator.frame = profileImage.frame
        self.view.addSubview(indicator)
        indicator.startAnimating()
        profileImage.layer.cornerRadius = profileImage.frame.width / 2.0
        profileImage.layer.borderColor = UIColor(red: 228/255, green: 150/255, blue: 144/255, alpha: 1.0).cgColor
        profileImage.layer.borderWidth = 8.0

        self.nameLabel.alpha = 0.0
        self.countLabel.alpha = 0.0
        self.profileImage.alpha = 0.0

        nameLabel.frame = CGRect(x: nameLabel.frame.minX, y: nameLabel.frame.minY + 10, width: nameLabel.frame.width, height: nameLabel.frame.height)
        countLabel.frame = CGRect(x: countLabel.frame.minX, y: countLabel.frame.minY + 10, width: countLabel.frame.width, height: countLabel.frame.height)

        Auth.auth().signIn(withEmail: "nathanmmacfarlane@gmail.com", password: "password") { user, error in
            if let user = Auth.auth().currentUser {
                self.getUserInfo(id: user.uid)
                Messaging.messaging().subscribe(toTopic: "trashFeed") { _ in
                    print("Subscribed to trashFeed topic")
                }
            }
        }
    }

    override
    func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        self.present(SendTrashTalk(), animated: true, completion: nil)
    }

    func getUserInfo(id: String) {
        Firestore.firestore().query(collection: "users", by: "id", with: id, of: User.self) { user in
            guard let user = user.first else { return }
            self.nameLabel.text = user.name
            self.countLabel.text = "Trashes Score: \(user.trashCount)pts"

            self.animateLabel(label: self.nameLabel)
            self.animateLabel(label: self.countLabel)

            URLSession.shared.dataTask(with: URL(string: user.profilePic)! as URL, completionHandler: { (data, response, error) -> Void in

                guard let data = data, let image = UIImage(data: data), (error == nil) else { return }
                DispatchQueue.main.async {
                    self.profileImage.image = image
                    UIView.animate(withDuration: 0.8) {
                        self.profileImage.alpha = 1.0
                    }
                    self.indicator.stopAnimating()
                }

            }).resume()
        }
    }

    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            self.present(SendTrashTalk(), animated: true, completion: nil)
        })
    }

    func animateLabel(label: UIView) {
        UIView.animate(withDuration: 0.8) {
            label.alpha = 1.0
            label.frame = CGRect(x: label.frame.minX, y: label.frame.minY - 10, width: label.frame.width, height: label.frame.height)
        }
    }
}

