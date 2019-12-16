import UIKit
import RealmSwift

class AstroObjTempTVC: UITableViewController {
    var planetsContainer: Results<AstronomicalObjectRealm>?
    var selectedPlanetName : String?
    
    let cellID = "AstroObjTempCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetsContainer = AstronomicalObjectInteraction().getAllAstronomicalObjects()
        
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetsContainer!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! AstroObjTempCell
        
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
        let destinationVC = segue.destination as! AstroObjTempDisplayVC
        
        destinationVC.receivedPlanetName = self.selectedPlanetName!
    }
 
}
