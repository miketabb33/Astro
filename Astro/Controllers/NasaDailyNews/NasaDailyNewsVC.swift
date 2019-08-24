import UIKit

class NasaDailyNewsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    
    let persistentData = PersistentData()
    let entryCellInsertionManager = EntryCellInsertionManager()
    let internetConnection = InternetConnection()
    let entryCellConstructor = EntryCellConstructor()
    
    var allNasaEntries = [NasaEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(NasaNewsEntryCell.self, forCellReuseIdentifier: "CustomNasaNewsEntryCell")
        tableView.rowHeight = 450
        
        internetConnection.startMonitoringInternetConnection()
        internetConnection.assignComponents(messageLabel: messageLabel, parentView: self.view)
        
        tableView.allowsSelection = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        allNasaEntries = persistentData.getAllNasaEntries()
        entryCellInsertionManager.addNextEntryToPageUnlessNoEntriesExist(allNasaEntries: allNasaEntries, tableView: tableView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        entryCellInsertionManager.loadMoreEntriesWhenSrollReachesBottom(tableView: tableView, allNasaEntries: allNasaEntries, isConnected: internetConnection.isConnected)
    }

}

extension NasaDailyNewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryCellInsertionManager.showingEntries
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(allNasaEntries[indexPath.row].cellHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomNasaNewsEntryCell", for: indexPath) as! NasaNewsEntryCell
        
        if allNasaEntries[indexPath.row].image == nil {
            if allNasaEntries[indexPath.row].url!.suffix(3) != "jpg" {
                saveAsYoutubeImage(indexPath: indexPath, allNasaEntries: allNasaEntries)
                entryCellConstructor.assignCell(cell: cell, indexPath: indexPath, allNasaEntries: allNasaEntries, tableView: tableView, parent: self)
                entryCellInsertionManager.addNextEntryToPageUnlessInitialLoadComplete(tableView: tableView)
            } else {
                let imageUrlString = allNasaEntries[indexPath.row].url!
                let imageUrl:URL = URL(string: imageUrlString)!
                let imageData:NSData = NSData(contentsOf: imageUrl)!
                allNasaEntries[indexPath.row].image = imageData as Data
                persistentData.saveNasaEntries()
                entryCellConstructor.assignCell(cell: cell, indexPath: indexPath, allNasaEntries: allNasaEntries, tableView: tableView, parent: self)
                entryCellInsertionManager.addNextEntryToPageUnlessInitialLoadComplete(tableView: tableView)
            }
        } else {
            entryCellConstructor.assignCell(cell: cell, indexPath: indexPath, allNasaEntries: allNasaEntries, tableView: tableView, parent: self)
            entryCellInsertionManager.addNextEntryToPageUnlessInitialLoadComplete(tableView: tableView)
        }
        
        return cell
    }
    
    func saveAsYoutubeImage(indexPath: IndexPath, allNasaEntries: [NasaEntry]) {
        allNasaEntries[indexPath.row].image = UIImage(named: "youtube")!.pngData()
        persistentData.saveNasaEntries()
    }
    
}
