import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        preloadData()
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

        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Astro")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private func preloadData() {
        let preloadedDataKey = "didPreloadedData"
        
        var dbPlanets = [Planets]()
        
        let userDefaults = UserDefaults.standard
        
        
        //This next line of code turns database preloding on. Be sure to clear the database before hand
        //userDefaults.set(false, forKey: preloadedDataKey)
        
        //DB Directory
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        if userDefaults.bool(forKey: preloadedDataKey) == false {
            
            guard let urlPath = Bundle.main.url(forResource: "PlanetData", withExtension: "plist") else {
                return
            }
            
            let backgroundContext = persistentContainer.newBackgroundContext()
            persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
            
            if let data = try? Data(contentsOf: urlPath) {
                let decoder = PropertyListDecoder()
                do {
                    let planetArray = try decoder.decode([planetUpload].self, from: data)
                    
                    backgroundContext.perform {
                        for (index, planet) in planetArray.enumerated() {
                            let currentPlanet = Planets(context: backgroundContext)
                            let convertableWeight : Decimal = Decimal(planet.relativeWeight)/1000000
    
                            currentPlanet.name = planet.name
                            currentPlanet.relativeWeight = convertableWeight as NSDecimalNumber
                            currentPlanet.position = Int16(index)
    
                            dbPlanets.append(currentPlanet)
                        }
    
                        do {
                            try backgroundContext.save()
                            userDefaults.set(true, forKey: preloadedDataKey)
                        } catch {
                            print("error preloading data: \(error)")
                        }
                    }
                    
                } catch {
                    print("Error decoding planet info plist: \(error)")
                }
            }
            
        }
        
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    

}

