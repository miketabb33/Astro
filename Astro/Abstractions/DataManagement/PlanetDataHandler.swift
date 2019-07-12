import UIKit
import CoreData

class PlanetDataHandler {
    var container = [Planets]()
    let persistentData = PersistentData()
    
    func sendPlanetDataToViews(firstView: UINavigationController?, secondView: UIViewController?) {
        container = persistentData.getPlanetData(planetContainer: container) ?? [Planets]()
        
        let planetTemperatureTVC = firstView?.topViewController as! PlanetTemperatureTVC
        let enterWeightVC = secondView as! EnterWeightVC
        
        planetTemperatureTVC.planetsContainer = container
        enterWeightVC.planetsContainer = container
    }
}
