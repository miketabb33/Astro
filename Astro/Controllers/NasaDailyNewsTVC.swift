import UIKit

class NasaDailyNewsTVC: UITableViewController {
    let persistentData = PersistentData()
    let nasaNewsEntryManager = NasaNewsEntryManager()
    let UIProcessing = NDNVCProcessing()
    let addConstraints = UIConstraints()
    
    var allNasaEntries = [NasaEntry]()
    var totalHeightForCell = CGFloat()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        allNasaEntries = persistentData.getAlllNasaEntries()
        
        tableView.register(NasaNewsEntryCell.self, forCellReuseIdentifier: "CustomNasaNewsEntryCell")
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nasaNewsEntryManager.showingEntries
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomNasaNewsEntryCell", for: indexPath) as! NasaNewsEntryCell
        totalHeightForCell = 0
        
        if allNasaEntries[indexPath.row].url!.suffix(3) != "jpg" {
            allNasaEntries[indexPath.row].image = UIImage(named: "youtube")!.pngData()
            persistentData.saveNasaEntries()
            
            assignCell(cell: cell, indexPath: indexPath)
        } else if allNasaEntries[indexPath.row].image == nil {
            let imageUrlString = allNasaEntries[indexPath.row].url!
            let imageUrl:URL = URL(string: imageUrlString)!

            DispatchQueue.global(qos: .userInitiated).async {

                let imageData:NSData = NSData(contentsOf: imageUrl)!

                DispatchQueue.main.async {
                    self.allNasaEntries[indexPath.row].image = imageData as Data
                    self.persistentData.saveNasaEntries()

                    self.assignCell(cell: cell, indexPath: indexPath)
                }
            }
        } else {
            assignCell(cell: cell, indexPath: indexPath)
        }
        
        return cell
    }
    
    func assignCell(cell: NasaNewsEntryCell, indexPath: IndexPath) {
        cell.currentEntryTitle.text = allNasaEntries[indexPath.row].title
        addConstraints.addConstraintForTopMostElementTo(cell.currentEntryTitle, topAnchor: cell.contentView.topAnchor, edges: cell.contentView.layoutMarginsGuide, height: cell.frameHeight["title"]!)
        
        cell.currentEntryImageView.image = UIImage(data: allNasaEntries[indexPath.row].image!)
        cell.currentEntryImageView = UIProcessing.processImage(currentCell: cell, stackUnder: cell.currentEntryTitle, edges: cell.contentView.safeAreaLayoutGuide)
        
        cell.currentEntryExplanation.text = allNasaEntries[indexPath.row].explanation
        addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: cell.frameHeight["explanation"]!)
        
        totalHeightForCell = cell.frameHeight["title"]! + cell.frameHeight["image"]! + cell.frameHeight["explanation"]!
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return totalHeightForCell
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       nasaNewsEntryManager.loadMoreEntriesWhenSrollReachesBottom(tableView: tableView, allNasaEntries: allNasaEntries)
    }

}
