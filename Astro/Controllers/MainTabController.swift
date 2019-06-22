import UIKit

class MainTabController: UITabBarController {
    let nasaDataHandler = NasaDataHandler()
    let planetDataHandler = PlanetDataHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //select which tab is displayed upon opening app.
        selectedViewController = self.viewControllers?[2]
        
        nasaDataHandler.sendNasaDailyNewsDataToView(viewControllers?[1])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        planetDataHandler.sendPlanetDataToViews(firstView: viewControllers?[0], secondView: viewControllers?[2])
    }
}
