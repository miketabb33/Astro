import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let entryNetworking = EntryNetworking()
    let entryImageNetworking = EntryImageNetworking()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AstronomicalObjectDataUpload().uploadUnlessCompleted(isCompleted: UserDefaultsMethods().getBoolean(key: UserDefaultsMethods().astroObjUploadCompletedKey))
        entryNetworking.SyncronizeAPODEntries()
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (timer) in
            if self.entryNetworking.isImageDownloadReady {
                self.entryImageNetworking.saveImagesAndCellHeight(startingFrom: 0, amount: 10, completion: nil)
                timer.invalidate()
            }
        }
        
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

