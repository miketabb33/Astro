//
//  AppDelegate.swift
//  Astro
//
//  Created by Michael Tabb on 4/9/19.
//  Copyright © 2019 Michael Tabb. All rights reserved.
//

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
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Astro")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
    
                            currentPlanet.name = planet.name
                            currentPlanet.image = planet.image
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    

}

