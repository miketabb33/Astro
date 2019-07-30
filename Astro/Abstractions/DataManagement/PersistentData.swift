import UIKit
import CoreData

class PersistentData {
    let preloadPlanetDataKey = "Planet-Data-Preloaded"
    let initialNasaEntryUploadCompletedKey = "Initial-Nasa-Entry-Upload-Completed"
    
    let userDefaults = UserDefaults.standard
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("error preloading data: \(error)")
        }
    }
    
    func savePlanetData(_ backgroundContext: NSManagedObjectContext) {
        do {
            try backgroundContext.save()
            userDefaults.set(true, forKey: preloadPlanetDataKey)
        } catch {
            print("error preloading data: \(error)")
        }
    }
    
    func getPlanetData(planetContainer: [Planets]) -> [Planets] {
        var container = planetContainer
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request : NSFetchRequest<Planets> = Planets.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "position", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            container = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        return container
    }
    
    func getLastLocalNasaEntry() -> [NasaEntry] {
        var container = [NasaEntry]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request : NSFetchRequest<NasaEntry> = NasaEntry.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        request.fetchLimit = 1
        
        do {
            container = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        return container
    }
    
    lazy var nasaEntriesContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAlllNasaEntries() -> [NasaEntry] {
        var container = [NasaEntry]()
        let request : NSFetchRequest<NasaEntry> = NasaEntry.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            container = try nasaEntriesContext.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        return container
    }
    
    func saveNasaEntries() {
        if nasaEntriesContext.hasChanges {
            do {
                try nasaEntriesContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func cleanNasaEntryDatabase() {
        let allNasaEntries = getAlllNasaEntries()
        for (index, entry) in allNasaEntries.enumerated() {
            //if index > 9 {
                entry.image = nil
            //}
        }
        saveNasaEntries()
    }
    
}