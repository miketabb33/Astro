import UIKit

class NasaDailyNewsTVC: UITableViewController {
    let persistentData = PersistentData()
    var allNasaEntries = [NasaEntry]()
    
    var nasaTitle = UILabel()
    var nasaDescription = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        allNasaEntries = persistentData.getAlllNasaEntries()
        
        tableView.register(NasaNewsEntryCell.self, forCellReuseIdentifier: "CustomNasaNewsEntryCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNasaEntries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomNasaNewsEntryCell", for: indexPath) as! NasaNewsEntryCell
        
        cell.currentEntryTitle.text = allNasaEntries[indexPath.row].title!
        cell.currentEntryImageContainer.image = UIImage(named: "Earth")
        //cell.currentEntryExplanation.text = allNasaEntries[indexPath.row].explanation!
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    

}
