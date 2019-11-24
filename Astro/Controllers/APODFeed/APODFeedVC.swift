import UIKit
import RealmSwift

class APODFeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var internetDetection: InternetDetection?
    let entryCellManager = EntryCellManager()
    let entryCellInsertionManager = EntryCellInsertionManager()
    
    let cellID = "APODEntryCell"
    
    var APODEntries = [APODEntryModel]()
    var showingEntryCount = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(APODEntryCell.self, forCellReuseIdentifier: cellID)
        
        internetDetection = InternetDetection(parentVC: self)
        internetDetection?.startMonitoringInternetConnection()
        
        APODEntries = APODEntryMethods().get(amount: showingEntryCount)
        
        //entryCellInsertionManager.addNextEntryToPageUnlessNoEntriesExist(allAPODEntries: allAPODEntries, tableView: tableView)
        tableView.allowsSelection = false
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //entryCellInsertionManager.loadMoreEntriesWhenSrollReachesBottom(tableView: tableView, allAPODEntries: allAPODEntries, isConnected: internetDetection!.isConnected!)
    }

}

extension APODFeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APODEntries.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(APODEntries[indexPath.row].cellHeight ?? 450)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! APODEntryCell
        var entry = APODEntries[indexPath.row]
        entry.image = UIImage(named: "youtube")!.pngData()
        
        //EntryCellConstructor().assignCell(cell: cell, indexPath: indexPath, allAPODEntries: APODEntries, tableView: tableView, parent: self)
        
        //entryCellManager.addNextCell(cell: cell, allAPODEntries: allAPODEntries, indexPath: indexPath, tableView: tableView, parent: self)
    
        return cell
    }
    
}
