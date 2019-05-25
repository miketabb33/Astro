import UIKit
import CoreData

class PlanetTemperatureTVC: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var planetsContainer = [Planets]()
    var selectedPlanetName : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPlanetData()
        
        tableView.register(UINib(nibName: "PlanetTempCell", bundle: nil), forCellReuseIdentifier: "CustomPlanetTempCell")

    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetsContainer.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomPlanetTempCell", for: indexPath) as! PlanetTempCell
        
        cell.planetCellImage.image = UIImage(named: planetsContainer[indexPath.row].name!)
        cell.planetName.text = planetsContainer[indexPath.row].name!

        tableView.rowHeight = 80

        return cell
    }
    
    //MARK - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPlanetName = planetsContainer[indexPath.row].name!
        performSegue(withIdentifier: "toPlanetTemp", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PlanetTemperatureVC
        
        destinationVC.receivedPlanetName = self.selectedPlanetName!
    }
 

    //MARK - Load planet data
    func loadPlanetData() {
        let request : NSFetchRequest<Planets> = Planets.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "position", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            planetsContainer = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
}
