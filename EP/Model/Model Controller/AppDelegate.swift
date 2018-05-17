//  AppDelegate.swift
import UIKit
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: AircraftListViewController())
        print("network")
        //Navigation bar
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor.black
        navigationBarAppearance.barTintColor = UIColor.epYellow()
        //navigationBarAppearance.setBackgroundImage(UIImage(named: ""), for: UIBarMetrics.default)
        //navigationBarAppearance.shadowImage = UIImage(named: "")
        return true
    }
}

