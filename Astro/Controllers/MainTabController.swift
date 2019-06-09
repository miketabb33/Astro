import UIKit

class MainTabController: UITabBarController {
    
    let fetchNasaDailyNewsData = FetchNasaDailyNewsData()
    var planetData = PlanetData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let planetTemperatureTVC = self.viewControllers?[0] as! PlanetTemperatureTVC
        let nasaDailyNewsView = self.viewControllers?[1] as! NasaDailyNewsVC
        let enterWeightVC = self.viewControllers?[2] as! EnterWeightVC
        
        planetData.loadPlanetData()
        planetTemperatureTVC.planetsContainer = planetData.container
        enterWeightVC.planetsContainer = planetData.container
        
        //Fetch Nasa Daily News
        
        let nasaDataCompletetionHandler: (Bool) -> Void = {
            if $0 {
                nasaDailyNewsView.nasaData = self.fetchNasaDailyNewsData.nasaData
            }
        }
        
        fetchNasaDailyNewsData.getNasaData(completion: nasaDataCompletetionHandler)

        //select which tab is displayed upon opening app.
        selectedViewController = self.viewControllers?[2]
    }
    
}
