import UIKit

class MainTabController: UITabBarController {
    
    let fetchNasaNailyNewsData = FetchNasaDailyNewsData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nasaDailyNewsView = self.viewControllers?[1] as! NasaDailyNewsVC
        
        let nasaDataCompletetionHandler: (Bool) -> Void = {
            if $0 {
                nasaDailyNewsView.nasaData = self.fetchNasaNailyNewsData.nasaData
            }
        }
        
        fetchNasaNailyNewsData.getNasaData(completion: nasaDataCompletetionHandler)

        //select which tab is displayed upon opening app.
        selectedViewController = self.viewControllers?[2]
    }
    
}
