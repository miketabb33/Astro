import UIKit
import Alamofire
import SwiftyJSON

class MainTabController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //select which tab is displayed upon opening app.
        selectedViewController = self.viewControllers?[2]
        
    }
    
}
