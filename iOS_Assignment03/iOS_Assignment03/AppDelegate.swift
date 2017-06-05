import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        
        let tabBars = [
            CityViewController(City(Location.Vancouver)),
            CityViewController(City(Location.Kenya)),
            CityViewController(City(Location.NewYork)),
            CityViewController(City(Location.Tokyo)),
            CityViewController(City(Location.Osaka))
        ]

        
        tabBarController.viewControllers = tabBars.map{
            $0.tabBarItem = $0.city.cityTabItem
            return UINavigationController(rootViewController: $0)
        }
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}

