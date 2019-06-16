import UIKit

class MainTabController: UITabBarController {
    
    let fetchNasaDailyNewsData = FetchNasaDailyNewsData()
    let planetData = PlanetData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendNasaDailyNewsDataToView()
        
        //select which tab is displayed upon opening app.
        selectedViewController = self.viewControllers?[2]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sendPlanetDataToViews()
    }
    
    //MARK: - Send data to views methods
    
    func sendNasaDailyNewsDataToView() {
        let nasaDailyNewsView = self.viewControllers?[1] as! NasaDailyNewsVC
        
        let nasaDataCompletetionHandler: (Bool) -> Void = {
            if $0 {
                nasaDailyNewsView.nasaData = self.fetchNasaDailyNewsData.nasaData
            }
        }
        
        fetchNasaDailyNewsData.getNasaData(completion: nasaDataCompletetionHandler)
    }
    
    func sendPlanetDataToViews() {
        planetData.loadPlanetData()
        let planetTemperatureTVC = self.viewControllers?[0] as! PlanetTemperatureTVC
        let enterWeightVC = self.viewControllers?[2] as! EnterWeightVC
        
        planetTemperatureTVC.planetsContainer = planetData.container
        enterWeightVC.planetsContainer = planetData.container
    }
    
}
