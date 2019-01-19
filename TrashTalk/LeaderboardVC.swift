import UIKit

class LeaderboardVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var leaderboardTableView: UITableView!
    var posts = [Post]()
    let imgView = UIImageView(frame: CGRect.zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        leaderboardTableView.delegate = self
        leaderboardTableView.dataSource = self
        print("here")
        imgView.frame = self.view.frame
        imgView.frame.size.height -= self.tabBarController!.tabBar.frame.height
        self.posts.append(Post(n:"TrashyMcTrashFace", p:UIImage(named: "trash")!.pngData()!))

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let imgvc = ImageViewController()
        imgvc.imgView.image = UIImage(data:posts[0].picData)
        self.present(imgvc, animated: true)
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
        cell.selectionStyle = .none
        return cell
    }
}
struct Post : Codable{
    let name:String
    let picData:Data
    init(n:String, p:Data) {
        name = n
        picData = p
    }
}
