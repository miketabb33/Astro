import UIKit
import RealmSwift

class WeightDisplayTVC: UITableViewController {
    var astronomicalObjContainer: Results<AstronomicalObjectRealm>?
    var enteredWeight : Double?
    
    let cellID = "RelativeWeightCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        astronomicalObjContainer = AstronomicalObjectCRUD().getAllAstronomicalObjects()
        
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }

    @IBAction func dismissButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension WeightDisplayTVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return astronomicalObjContainer!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RelativeWeightCell
        
        let currentObject = astronomicalObjContainer![indexPath.row]
        
        let userWeightOnThisObj = currentObject.relativeWeight * enteredWeight!
        let formattedUserWeight = FormatterMethods().roundTo2DecimalPlaces(weight: userWeightOnThisObj)
        cell.weightLabel.text = "\(formattedUserWeight) lbs"
        
        cell.objectName.text = currentObject.name
        cell.objectImage.image = UIImage(named: currentObject.name)
        
        tableView.rowHeight = 80
        tableView.allowsSelection = false
        
        return cell
    }
}
