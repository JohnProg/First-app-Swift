import UIKit
import SharkORM

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SRKDelegate {

    var window: UIWindow?

    override init() {
        super.init()
        SharkORM.setDelegate(self)
        SharkORM.openDatabaseNamed("Employee")
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
     
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    
    }

    func applicationWillTerminate(_ application: UIApplication) {
    
    }


}

