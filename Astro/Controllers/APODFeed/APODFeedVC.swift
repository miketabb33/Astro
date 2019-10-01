import UIKit
import RealmSwift

class APODFeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    
    let internetConnection = InternetDetection()
    let entryCellManager = EntryCellManager()
    let entryCellInsertionManager = EntryCellInsertionManager()
    
    let cellID = "APODEntryCell"
    
    var allAPODEntries: Results<APODEntry>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(APODEntryCell.self, forCellReuseIdentifier: cellID)
        tableView.rowHeight = 450
        
        internetConnection.startMonitoringInternetConnection()
        internetConnection.assignComponents(messageLabel: messageLabel, parentView: self.view)
        
        tableView.allowsSelection = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        allAPODEntries = RealmMethods().getAllAPODEntries()
        entryCellInsertionManager.addNextEntryToPageUnlessNoEntriesExist(allAPODEntries: allAPODEntries!, tableView: tableView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        entryCellInsertionManager.loadMoreEntriesWhenSrollReachesBottom(tableView: tableView, allAPODEntries: allAPODEntries!, isConnected: internetConnection.isConnected)
    }

}

extension APODFeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryCellInsertionManager.showingEntries
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(allAPODEntries![indexPath.row].cellHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! APODEntryCell
        
        entryCellManager.addNextCell(cell: cell, allAPODEntries: allAPODEntries!, indexPath: indexPath, tableView: tableView, parent: self)
    
        return cell
    }
    
}
