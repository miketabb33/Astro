import UIKit
import CoreData

class PlanetData {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var container = [Planets]()
    
    func loadPlanetData() {
        let request : NSFetchRequest<Planets> = Planets.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "position", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            container = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
}
