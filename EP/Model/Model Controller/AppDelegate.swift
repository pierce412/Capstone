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
        window?.backgroundColor = UIColor.mainColorScheme1()
        //Navigation bar
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor.offWhite()
        navigationBarAppearance.barTintColor = UIColor.mainColorScheme1()
        navigationBarAppearance.backgroundColor = UIColor.white
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.offWhite()]
        navigationBarAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.offWhite()]
        //status bar style, changed plist too 
        application.statusBarStyle = .lightContent
        return true
    }
    func applicationWillTerminate(_ application: UIApplication) {
        print("Application Will Terminate")
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Application Did enter background")
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("Application will enter foreground")
    }
    func applicationWillResignActive(_ application: UIApplication) {
        print("Application will resign active")
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("Application did become active")
    }
}

