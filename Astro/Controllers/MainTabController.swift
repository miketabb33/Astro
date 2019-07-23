import UIKit

class MainTabController: UITabBarController {
    let planetDataHandler = PlanetDataHandler()

    var container = [Planets]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //select which tab is displayed upon opening app.
        selectedViewController = self.viewControllers?[2]
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        planetDataHandler.sendPlanetDataToViews(firstView: viewControllers?[0] as? UINavigationController, secondView: viewControllers?[2])
    }
    
}
