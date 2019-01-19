protocol Noti {
    var title: String { get set }
    var date: Double { get }
    var id: String { get }
}

class Notification: Noti, Codable {
    var title: String
    var date: Double
    var id: String
    var trashId: String

    init(title: String, date: Double, id: String, trashId: String) {
        self.title = title
        self.date = date
        self.id = id
        self.trashId = trashId
    }
}
