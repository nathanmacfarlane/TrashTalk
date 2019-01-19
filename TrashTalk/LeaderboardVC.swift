import UIKit
import Firebase

class LeaderboardVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var leaderboardTableView: UITableView!

    var people: [User] = []
    @IBOutlet weak var trashKingLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.leaderboardTableView.delegate = self
        self.leaderboardTableView.dataSource = self
        Firestore.firestore().queryAll(collection: "users", of: User.self) { users in
            self.people = users.sorted { $0.trashCount > $1.trashCount }
            self.leaderboardTableView.reloadData()
            self.trashKingLabel.text = "Trash King: \(self.people.first?.trashCount ?? 0)"
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TrashTableViewCell

        cell.nameLabel.text = people[indexPath.row].name
        cell.trashLabel.text = "Trash Count: \(people[indexPath.row].trashCount)"

        return cell
    }

        // Configure your cell:
//        cell.textLabel?.text       = people[indexPath.row].name
//        cell.detailTextLabel?.text = "\(people[indexPath.row].trashCount)"
//    }


}
