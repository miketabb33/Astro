import UIKit
import CoreData

class WeightDisplayTVC: UITableViewController {
    
    var planetsContainer = [Planets]()
    
    let decimalFormatter = NumberFormatter()
    
    var enteredWeight : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "PlanetCell", bundle: nil), forCellReuseIdentifier: "CustomPlanetCell")
    }
    
    //MARK - Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetsContainer.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomPlanetCell", for: indexPath) as! PlanetWeightCell
        
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.maximumFractionDigits = 2
        
        let currentPlanet = planetsContainer[indexPath.row]
        
        if enteredWeight != nil {
            let weight = ((currentPlanet.relativeWeight! as Decimal) * Decimal(enteredWeight!)) as Any?
            if let value = weight {
                let stringWeight = decimalFormatter.string(from: value as! NSNumber)
                cell.weightLabel.text = "\(stringWeight!) lbs"
            }
            
        }
        
        cell.planetName.text = currentPlanet.name!
        cell.planetCellImage.image = UIImage(named: currentPlanet.name!)
        
        tableView.rowHeight = 80
        tableView.allowsSelection = false
        
        return cell
    }
    
    //MARK - Dismiss Nav Controller
    
    @IBAction func dismissButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
