import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let stockNavigationController = UINavigationController()
        let stockViewController = StockViewController(nibName:"StockViewController", bundle: nil)
        stockNavigationController.title = "Stock"
        stockNavigationController.tabBarItem.image = UIImage(named:"stock")
        stockNavigationController.setViewControllers([stockViewController], animated: true)
        
        let entryNavigationController = UINavigationController()
        let entryViewController = EntryViewController(nibName:"EntryViewController", bundle: nil)
        entryNavigationController.title = "Ingresos"
        entryNavigationController.tabBarItem.image = UIImage(named:"entry")
        entryNavigationController.setViewControllers([entryViewController], animated: true)
        
        let egressNavigationController = UINavigationController()
        let egressViewController = EgressViewController(nibName:"EgressViewController", bundle: nil)
        egressNavigationController.title = "Egresos"
        egressNavigationController.tabBarItem.image = UIImage(named:"egress")
        egressNavigationController.setViewControllers([egressViewController], animated: true)
        
        let movementsNavigationController = UINavigationController()
        let movementsViewController = MovementsViewController(nibName:"MovementsViewController", bundle: nil)
        movementsNavigationController.title = "Movimientos"
        movementsNavigationController.tabBarItem.image = UIImage(named:"movement")
        movementsNavigationController.setViewControllers([movementsViewController], animated: true)
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([stockNavigationController, entryNavigationController, egressNavigationController, movementsNavigationController], animated: true)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = tabBarController
        self.window!.makeKeyAndVisible()
        
        UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            if granted {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        
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

