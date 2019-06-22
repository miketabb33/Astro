import UIKit

class WeightDisplayTVC: UITableViewController {
    let formatterMethods = FormatterMethods()
    let mathMethods = MathMethods()
    
    var planetsContainer = [Planets]()
    var enteredWeight : Double?
    
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
        
        let currentPlanet = planetsContainer[indexPath.row]
        let relativeEnteredWeight = mathMethods.findRelativeEnteredWeightInlbs(relativeWeight: currentPlanet.relativeWeight! as Decimal, enteredWeight: enteredWeight!)
        
        cell.weightLabel.text = formatterMethods.formatWeight(relativeEnteredWeight)
        cell.planetName.text = currentPlanet.name!
        cell.planetCellImage.image = UIImage(named: currentPlanet.name!)
        
        tableView.rowHeight = 80
        tableView.allowsSelection = false
        
        return cell
    }
    
    //MARK - Navigation
    
    @IBAction func dismissButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
