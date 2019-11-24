import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let userDefaultsMethods = UserDefaultsMethods()
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        APODEntryMethods().cleanAPODDatabase()
        AstronomicalObjectDBInjection().uploadAstronomicalObjectsUnlessCompleted(isCompleted: UserDefaultsMethods().getUserDefaultsForBoolean(key: UserDefaultsMethods().astronomicalObjectPreloadCompletedKey))
        APODEntryDBInjection().SyncronizeAPODEntries()
        
        //Line below prints location of realm Database
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
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

