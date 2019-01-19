import UIKit
import Firebase

class LeaderboardVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var leaderboardTableView: UITableView!

    var people: [User] = []
    @IBOutlet weak var trashKingLabel: UILabel!
    @IBOutlet weak var kingImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.leaderboardTableView.delegate = self
        self.leaderboardTableView.dataSource = self

        kingImageView.layer.cornerRadius = kingImageView.frame.width / 2.0
        kingImageView.layer.borderColor = UIColor(red: 228/255, green: 150/255, blue: 144/255, alpha: 1.0).cgColor
        kingImageView.layer.borderWidth = 5.0
        kingImageView.alpha = 0.0

        leaderboardTableView.separatorStyle = .none
        leaderboardTableView.allowsSelection = false

        Firestore.firestore().queryAll(collection: "users", of: User.self) { users in
            self.people = users.sorted { $0.trashCount > $1.trashCount }
            self.leaderboardTableView.reloadData()
            self.trashKingLabel.text = "Trash King: \(self.people.first?.trashCount ?? 0) pts"

            guard let user = self.people.first else { return }
            URLSession.shared.dataTask(with: URL(string: user.profilePic)! as URL, completionHandler: { (data, response, error) -> Void in
                guard let data = data, let image = UIImage(data: data), (error == nil) else { return }
                DispatchQueue.main.async {
                    self.kingImageView.image = image
                    self.kingImageView.alpha = 1.0
                }

            }).resume()
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
        cell.trashLabel.text = "\(people[indexPath.row].trashCount)"
        cell.backgroundColor = .clear
        cell.bgView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)

        return cell
    }


}
