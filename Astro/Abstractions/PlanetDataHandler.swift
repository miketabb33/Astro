import UIKit
import CoreData

class PlanetDataHandler {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var container = [Planets]()
    
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
    
    func sendPlanetDataToViews(firstView: UIViewController?, secondView: UIViewController?) {
        loadData()
        let planetTemperatureTVC = firstView as! PlanetTemperatureTVC
        let enterWeightVC = secondView as! EnterWeightVC
        
        planetTemperatureTVC.planetsContainer = container
        enterWeightVC.planetsContainer = container
    }
    
}
