import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Line below prints location of realm Database
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        AstronomicalObjectDataUpload().uploadUnlessCompleted(isCompleted: UserDefaultsMethods().getBoolean(key: UserDefaultsMethods().astroObjUploadCompletedKey))
        
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
