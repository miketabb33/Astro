import UIKit
import CoreData
import RealmSwift

class APODEntry: Object {
    @objc dynamic var explanation = ""
    @objc dynamic var url = ""
    @objc dynamic var title = ""
    @objc dynamic var date = ""
}

class PersistentData {
    let realm = try! Realm()
    
    let preloadPlanetDataKey = "Planet-Data-Preloaded"
    let initialNasaEntryUploadCompletedKey = "Initial-Nasa-Entry-Upload-Completed"
    
    func addAPOD(data: [APODEntry]) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    
    
    
    let userDefaults = UserDefaults.standard
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("error preloading data: \(error)")
        }
    }
    
    //MARK: - Planet Data Methods
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
    
    //MARK: - NASA Entry Feed Data Methods
    lazy var nasaEntriesContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllNasaEntries() -> [NasaEntry] {
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
    
    func insertDataIntoDatabase(stagedNasaData: [NDNAPIStagingModel]) {
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        let backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.perform {
            for currentEntry in stagedNasaData {
                let container = NasaEntry(context: backgroundContext)
                container.title = currentEntry.title
                container.date = currentEntry.date
                container.explanation = currentEntry.explanation
                container.url = currentEntry.url
                self.saveContext(backgroundContext)
            }
            
        }
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
    
    func cleanNasaEntryDatabase() {
        let allNasaEntries = getAllNasaEntries()
        for (index, entry) in allNasaEntries.enumerated() {
            if index > 19 {
                entry.image = nil
            }
            entry.cellHeight = 0
            entry.expandEnabled = false
        }
        saveNasaEntries()
    }
    
}
