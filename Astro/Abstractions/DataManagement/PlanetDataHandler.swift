import UIKit
import CoreData

class PlanetDataHandler {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var container = [Planets]()
    
    func sendPlanetDataToViews(firstView: UINavigationController?, secondView: UIViewController?) {
        loadData()
        let planetTemperatureTVC = firstView?.topViewController as! PlanetTemperatureTVC
        let enterWeightVC = secondView as! EnterWeightVC
        
        planetTemperatureTVC.planetsContainer = container
        enterWeightVC.planetsContainer = container
    }
    
    func loadData() {
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
