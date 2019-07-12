import UIKit
import CoreData

class PersistentData {
    let preloadDataKey = "Planet-Data-Preloaded"
    let userDefaults = UserDefaults.standard
    
    func attemptToSaveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("error preloading data: \(error)")
        }
    }
    
    func savePlanetData(_ backgroundContext: NSManagedObjectContext) {
        do {
            try backgroundContext.save()
            userDefaults.set(true, forKey: preloadDataKey)
        } catch {
            print("error preloading data: \(error)")
        }
    }
    
    func getPlanetData(planetContainer: [Planets]) -> [Planets]? {
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
    
}
