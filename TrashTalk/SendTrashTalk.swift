import Foundation
import Firebase
import UIKit

class SendTrashTalk: UIViewController {

    var trash: [String] = [
        "Get some",
        "Suck it",
        "You're the worst",
        "I'm the best",
        "Some Trash",
        "UR 🗑"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        Firestore.firestore().queryAll(collection: "users", of: User.self) { users in
            for user in users {
                print("name: \(user.name)")
            }
        }

        view.backgroundColor = .gray

        let button = UIButton()
        button.setTitle("Send Trash", for: .normal)
        button.addTarget(self, action: #selector(goAddFriends), for: .touchUpInside)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20).isActive = true
        NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50).isActive = true
        NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60).isActive = true
    }

    @objc
    func goAddFriends() {
        let optionMenu = UIAlertController(title: nil, message: "Send Trash to Friends", preferredStyle: .actionSheet)
        let trash1 = UIAlertAction(title: getTrashTalk(), style: .default) { actionItem in
            self.pushToFriends(title: actionItem.title)
        }
        let trash2 = UIAlertAction(title: getTrashTalk(), style: .default) { actionItem in
            self.pushToFriends(title: actionItem.title)
        }
        let trash3 = UIAlertAction(title: getTrashTalk(), style: .default) { actionItem in
            self.pushToFriends(title: actionItem.title)
        }
        optionMenu.addAction(trash1)
        optionMenu.addAction(trash2)
        optionMenu.addAction(trash3)
        self.present(optionMenu, animated: true, completion: nil)
    }

    func pushToFriends(title: String?) {
        guard let user = Auth.auth().currentUser else { return }
        Firestore.firestore().query(collection: "users", by: "id", with: user.uid, of: User.self) { user in
            guard let user = user.first, let title = title else { return }

            let newNoti = Notification(title: "'\(title)' -\(user.name)", date: 35.0, id: UUID().uuidString, trashId: "7654")
            Firestore.firestore().save(object: newNoti, to: "notifications", with: newNoti.id) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    func getTrashTalk() -> String {
        let randomIndex = Int(arc4random_uniform(UInt32(trash.count)))
        let trash1 = trash[randomIndex]
        trash.remove(at: randomIndex)
        return trash1
    }
}
