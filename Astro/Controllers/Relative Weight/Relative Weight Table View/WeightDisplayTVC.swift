import UIKit
import RealmSwift

class WeightDisplayTVC: UITableViewController {
    var planetsContainer: Results<AstronomicalObject>?
    var enteredWeight : Double?
    
    let cellID = "RelativeWeightCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetsContainer = RealmMethods().getAllAstronomicalObjects()
        
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    //MARK - Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetsContainer!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RelativeWeightCell
        
        let currentPlanet = planetsContainer![indexPath.row]
        
        cell.weightLabel.text = FormatterMethods().getRelativeWeight(objectRelativeWeight: currentPlanet.relativeWeight, enteredWeight: enteredWeight!)
        cell.planetName.text = currentPlanet.name
        cell.planetCellImage.image = UIImage(named: currentPlanet.name)
        
        tableView.rowHeight = 80
        tableView.allowsSelection = false
        
        return cell
    }
    
    //MARK - Navigation
    
    @IBAction func dismissButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
