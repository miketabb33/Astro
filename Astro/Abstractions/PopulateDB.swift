import UIKit
import CoreData

class PopulateDB {
    
    let preloadedDataKey = "didPreloadedData"
    var dbPlanets = [Planets]()
    let userDefaults = UserDefaults.standard
    
    lazy var persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    func preloadData() {
        if userDefaults.bool(forKey: preloadedDataKey) == false {
            attemptToLoadAndSaveContext()
        }
    }
    
    func attemptToLoadAndSaveContext() {
        guard let urlPath = Bundle.main.url(forResource: "PlanetData", withExtension: "plist") else { fatalError() }
        let backgroundContext = persistentContainer.newBackgroundContext()
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        
        if let data = try? Data(contentsOf: urlPath) {
            let decoder = PropertyListDecoder()
            do {
                let planetArray = try decoder.decode([planetUpload].self, from: data)
                
                backgroundContext.perform {
                    self.loadContextWithPlanetData(planetArray, backgroundContext: backgroundContext)
                    self.attemptToSaveContext(backgroundContext)
                }
                
            } catch {
                print("Error decoding planet info plist: \(error)")
            }
        }
    }
    
    func loadContextWithPlanetData(_ planetArray: [planetUpload], backgroundContext: NSManagedObjectContext) {
        for (index, planet) in planetArray.enumerated() {
            let currentPlanet = Planets(context: backgroundContext)
            let convertableWeight : Decimal = Decimal(planet.relativeWeight)/1000000
            
            currentPlanet.name = planet.name
            currentPlanet.relativeWeight = convertableWeight as NSDecimalNumber
            currentPlanet.position = Int16(index)
            
            self.dbPlanets.append(currentPlanet)
        }
    }
    
    func attemptToSaveContext(_ backgroundContext: NSManagedObjectContext) {
        do {
            try backgroundContext.save()
            self.userDefaults.set(true, forKey: self.preloadedDataKey)
        } catch {
            print("error preloading data: \(error)")
        }
    }
}

//This next line of code turns database preloding on. Be sure to clear the database before hand
//userDefaults.set(false, forKey: preloadedDataKey)

//DB Directory
//print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
