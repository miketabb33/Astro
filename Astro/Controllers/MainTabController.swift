import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class MainTabController: UITabBarController {
    let nasaDataHandler = NasaDataHandler()
    let planetDataHandler = PlanetDataHandler()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var container = [Planets]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //select which tab is displayed upon opening app.
        selectedViewController = self.viewControllers?[2]
        
        nasaDataHandler.sendNasaDailyNewsDataToView(viewControllers?[1])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        planetDataHandler.sendPlanetDataToViews(firstView: viewControllers?[0] as? UINavigationController, secondView: viewControllers?[2])
    }
    
}
