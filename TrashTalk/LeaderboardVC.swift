import UIKit

class LeaderboardVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var leaderboardTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        leaderboardTableView.delegate = self
        leaderboardTableView.dataSource = self
        print("here")
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.leaderboardTableView.dequeueReusableCell(withIdentifier: "Cell") as! TrashTableViewCell
        cell.thumb.image = UIImage(named:"trash")
        cell.name.text = "trashy mcTrashface"
        cell.place.text =  String(describing: indexPath.row+1)
        cell.place.sizeToFit()
        cell.name.sizeToFit()
        return cell
    }
    
    


}
