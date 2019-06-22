import UIKit

class PlanetTemperatureVC: UIViewController {
    @IBOutlet weak var planetName: UILabel!
    @IBOutlet weak var planetImage: UIImageView!
    
    var receivedPlanetName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetName.text = receivedPlanetName
        planetImage.image = UIImage(named: receivedPlanetName!)
        
    }

}
