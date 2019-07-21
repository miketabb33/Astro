import UIKit

class NasaDailyNewsTVC: UITableViewController {
    let persistentData = PersistentData()
    var allNasaEntries = [NasaEntry]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        allNasaEntries = persistentData.getAlllNasaEntries()
        
        tableView.register(NasaNewsEntryCell.self, forCellReuseIdentifier: "CustomNasaNewsEntryCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfShowingEntries
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomNasaNewsEntryCell", for: indexPath) as! NasaNewsEntryCell
        
        if allNasaEntries[indexPath.row].image == nil {
            let imageUrlString = allNasaEntries[indexPath.row].url!
            let imageUrl:URL = URL(string: imageUrlString)!
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                let imageData:NSData = NSData(contentsOf: imageUrl)!
                
                DispatchQueue.main.async {
                    self.allNasaEntries[indexPath.row].image = imageData as Data
                    self.persistentData.saveNasaEntries()
                    
                    cell.currentEntryTitle.text = self.allNasaEntries[indexPath.row].title
                    cell.currentEntryImageView.image = UIImage(data: self.allNasaEntries[indexPath.row].image!)
                }
            }
        } else {
            cell.currentEntryTitle.text = self.allNasaEntries[indexPath.row].title
            cell.currentEntryImageView.image = UIImage(data: self.allNasaEntries[indexPath.row].image!)
        }
    
        
        //cell.currentEntryExplanation.text = allNasaEntries[indexPath.row].explanation!
        
        return cell
    }
    
    var i = 0
    var reachedEnd = false
    var numberOfShowingEntries = 4
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if numberOfShowingEntries <= allNasaEntries.count {
            if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) {
                numberOfShowingEntries = numberOfShowingEntries + 1
                i = i + 1
                print("end, \(i)")
                if numberOfShowingEntries <= allNasaEntries.count {
                    tableView.reloadData()
                }
            }
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

}
