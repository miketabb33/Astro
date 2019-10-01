import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let userDefaultsMethods = UserDefaultsMethods()
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        RealmMethods().cleanAPODDatabase()
        AstronomicalObjectInjection().preloadAstronomicalObjectsUnlessCompleted()
        APODInjection().updateAPODEntries(initialUploadCompleted: userDefaultsMethods.getUserDefaultsForBoolean(key: userDefaultsMethods.initialAPODUploadCompletedKey))
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
        RealmMethods().cleanAPODDatabase()
    }

}

