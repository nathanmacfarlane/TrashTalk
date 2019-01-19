import UIKit
import Firebase

class TrashDetailView: UIViewController {

    var trashId: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        let nameLabel = UILabel()
        nameLabel.text = ""
        nameLabel.textAlignment = .center
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20).isActive = true
        NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40).isActive = true

        let db = Firestore.firestore()
        db.query(collection: "trashes", by: "id", with: trashId, of: Trash.self) { trash in
            guard let trash = trash.first else { return }
            db.query(collection: "users", by: "id", with: trash.userId, of: User.self, completion: { user in
                guard let user = user.first else { return }
                nameLabel.text = user.name
            })
        }

        self.view.backgroundColor = .gray
        
    }

}
