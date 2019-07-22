import UIKit

class NasaDailyNewsTVC: UITableViewController {
    let persistentData = PersistentData()
    let nasaNewsEntryManager = NasaNewsEntryManager()
    let UIProcessing = NDNVCProcessing()
    var allNasaEntries = [NasaEntry]()
    
    var totalHeightForCell = CGFloat()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        allNasaEntries = persistentData.getAlllNasaEntries()
        
        tableView.register(NasaNewsEntryCell.self, forCellReuseIdentifier: "CustomNasaNewsEntryCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        tableView.isHidden = false
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nasaNewsEntryManager.showingEntries
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomNasaNewsEntryCell", for: indexPath) as! NasaNewsEntryCell
        totalHeightForCell = 0
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
                    cell.currentEntryImageView = self.UIProcessing.processImage(cell.currentEntryImageView, stackUnder: cell.currentEntryTitle, edges: cell.contentView.safeAreaLayoutGuide)
                    print(cell.currentEntryImageView.frame.height)
                }
            }
        } else {
            cell.currentEntryTitle.text = self.allNasaEntries[indexPath.row].title
            cell.currentEntryImageView.image = UIImage(data: self.allNasaEntries[indexPath.row].image!)
            cell.currentEntryImageView = UIProcessing.processImage(cell.currentEntryImageView, stackUnder: cell.currentEntryTitle, edges: cell.contentView.safeAreaLayoutGuide)
            
        }
        
        totalHeightForCell = cell.currentEntryImageView.frame.height + cell.currentEntryTitle.frame.height
        //cell.currentEntryExplanation.text = allNasaEntries[indexPath.row].explanation!
        print(totalHeightForCell)
        
        return cell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return totalHeightForCell
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       nasaNewsEntryManager.loadMoreEntriesWhenSrollReachesBottom(tableView: tableView, allNasaEntries: allNasaEntries)
    }

}
