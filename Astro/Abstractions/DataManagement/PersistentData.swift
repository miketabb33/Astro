import UIKit
import CoreData

class PersistentData {
    lazy var persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
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
    
    func attemptToSaveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
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
