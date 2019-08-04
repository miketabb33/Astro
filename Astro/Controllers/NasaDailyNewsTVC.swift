import UIKit

class NasaDailyNewsTVC: UITableViewController {
    let persistentData = PersistentData()
    let nasaNewsEntryManager = NasaNewsEntryManager()
    let UIProcessing = NDNVCProcessing()
    let addConstraints = UIConstraints()
    let internetConnection = InternetConnection()
    
    var allNasaEntries = [NasaEntry]()
    var totalHeightForCell = CGFloat()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nasaNewsEntryManager.loadingAnimation.show()
        tableView.register(NasaNewsEntryCell.self, forCellReuseIdentifier: "CustomNasaNewsEntryCell")
        tableView.rowHeight = 450
        
        internetConnection.startMonitoringInternetConnection()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        allNasaEntries = persistentData.getAllNasaEntries()
        nasaNewsEntryManager.addNextEntryToPageUnlessNoEntriesExist(allNasaEntries: allNasaEntries, tableView: tableView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        nasaNewsEntryManager.loadingAnimation.hide()
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nasaNewsEntryManager.showingEntries
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomNasaNewsEntryCell", for: indexPath) as! NasaNewsEntryCell
        
        if allNasaEntries[indexPath.row].image == nil {
            if allNasaEntries[indexPath.row].url!.suffix(3) != "jpg" {
                nasaNewsEntryManager.saveAsYoutubeImage(indexPath: indexPath, allNasaEntries: allNasaEntries)
                assignCell(cell: cell, indexPath: indexPath)
                nasaNewsEntryManager.addNextEntryToPageUnlessInitialLoadComplete(tableView: tableView)
            } else {
                let imageUrlString = allNasaEntries[indexPath.row].url!
                let imageUrl:URL = URL(string: imageUrlString)!
                
                let imageData:NSData = NSData(contentsOf: imageUrl)!
                allNasaEntries[indexPath.row].image = imageData as Data
                persistentData.saveNasaEntries()
                assignCell(cell: cell, indexPath: indexPath)
                nasaNewsEntryManager.addNextEntryToPageUnlessInitialLoadComplete(tableView: tableView)
            }
        } else {
            assignCell(cell: cell, indexPath: indexPath)
            nasaNewsEntryManager.addNextEntryToPageUnlessInitialLoadComplete(tableView: tableView)
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
        
        if allNasaEntries[indexPath.row].cellHeight == 0 {
            allNasaEntries[indexPath.row].cellHeight = Float(cell.frameHeight["title"]! + cell.frameHeight["image"]! + cell.frameHeight["explanation"]!)
            persistentData.saveNasaEntries()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(allNasaEntries[indexPath.row].cellHeight)
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        nasaNewsEntryManager.loadMoreEntriesWhenSrollReachesBottom(tableView: tableView, allNasaEntries: allNasaEntries, isConnected: internetConnection.isConnected)
    }

}
