import UIKit
import RealmSwift

class PlanetTemperatureTVC: UITableViewController {
    let persistentData = PersistentData()
    
    var planetsContainer: Results<AstronomicalObject>?
    var selectedPlanetName : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetsContainer = persistentData.getAllAstronomicalObjects()
        
        tableView.register(UINib(nibName: "PlanetTempCell", bundle: nil), forCellReuseIdentifier: "CustomPlanetTempCell")
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetsContainer!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomPlanetTempCell", for: indexPath) as! PlanetTempCell
        
        cell.planetCellImage.image = UIImage(named: planetsContainer![indexPath.row].name)
        cell.planetName.text = planetsContainer![indexPath.row].name

        tableView.rowHeight = 80

        return cell
    }
    
    //MARK - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPlanetName = planetsContainer![indexPath.row].name
        performSegue(withIdentifier: "toPlanetTemp", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PlanetTemperatureVC
        
        destinationVC.receivedPlanetName = self.selectedPlanetName!
    }
 
}
