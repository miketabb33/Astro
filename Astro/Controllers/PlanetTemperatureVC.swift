import UIKit

class PlanetTemperatureVC: UIViewController {
    
    var receivedPlanetName : String?
    
    @IBOutlet weak var planetName: UILabel!
    
    @IBOutlet weak var planetImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetName.text = receivedPlanetName
        planetImage.image = UIImage(named: receivedPlanetName!)
        
    }

}
