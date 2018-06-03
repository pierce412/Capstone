////  AppDelegate.swift
import UIKit
import Firebase
import StoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    //declare an instance of IAPService in order to add the observer at the app level
    let observer = IAPService()

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        //IAP setup
        IAPService.shared.getProducts()
        //print("products fetched")
        SKPaymentQueue.default().add(observer)
        print("payment queue observer added")
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let loginController = LoginViewController()
        window?.rootViewController = UINavigationController(rootViewController: loginController)
        if(Auth.auth().currentUser != nil){
            let navcon = UINavigationController(rootViewController: AircraftListViewController())
            loginController.present(navcon, animated: false, completion: nil)
        }
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
        //remove storeKit observer
        SKPaymentQueue.default().remove(observer)
        print("Payment Queue observer removed")
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

