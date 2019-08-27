import UIKit

class NasaDailyNewsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    
    let persistentData = PersistentData()
    let internetConnection = InternetConnection()
    let entryCellManager = EntryCellManager()
    
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
        entryCellManager.entryCellInsertionManager.addNextEntryToPageUnlessNoEntriesExist(allNasaEntries: allNasaEntries, tableView: tableView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        entryCellManager.entryCellInsertionManager.loadMoreEntriesWhenSrollReachesBottom(tableView: tableView, allNasaEntries: allNasaEntries, isConnected: internetConnection.isConnected)
    }

}

extension NasaDailyNewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryCellManager.entryCellInsertionManager.showingEntries
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(allNasaEntries[indexPath.row].cellHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomNasaNewsEntryCell", for: indexPath) as! NasaNewsEntryCell
        
        entryCellManager.addNextCell(cell: cell, allNasaEntries: allNasaEntries, indexPath: indexPath, tableView: tableView, parent: self)
    
        return cell
    }
    
}