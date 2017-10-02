import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let entryNavigationController = UINavigationController()
        entryNavigationController.title = "Ingresos"
        entryNavigationController.setViewControllers([ViewController()], animated: true)
        
        let egressNavigationController = UINavigationController()
        egressNavigationController.title = "Egresos"
        egressNavigationController.setViewControllers([ViewController()], animated: true)
        
        let movementsNavigationController = UINavigationController()
        movementsNavigationController.title = "Movimientos"
        movementsNavigationController.setViewControllers([ViewController()], animated: true)
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([entryNavigationController, egressNavigationController, movementsNavigationController], animated: true)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = tabBarController
        self.window!.makeKeyAndVisible()
        
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

