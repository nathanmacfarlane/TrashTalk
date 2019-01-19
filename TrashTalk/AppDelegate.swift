import CodableFirebase
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        registerForPushNotifications()
        return true
    }

    func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            // 1. Check if permission granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        guard let aps = userInfo["aps"] as? [String: AnyObject] else {
            completionHandler(.failed)
            return
        }
        handleNotification(aps: aps)
//        print("aps: \(aps)")
//        if let noti = try? FirebaseDecoder().decode(Notification.self, from: aps) {
//            print("notification title: \(noti.title)")
//            let tdv = TrashDetailView()
//            tdv.trashId = noti.trashId
//            self.window?.rootViewController = tdv
//        }
    }

    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }

    func handleNotification(aps: [String: AnyObject]) {
        print("aps: \(aps)")
        if let noti = try? FirebaseDecoder().decode(Notification.self, from: aps) {
            print("notification title: \(noti.title)")
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 1. Convert device token to string
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        // 2. Print device token to use for PNs payloads
        print("Device Token: \(token)")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // 1. Print out error if PNs registration not successful
        print("Failed to register for remote notifications with error: \(error)")
    }

}

