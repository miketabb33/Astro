import UIKit

class APODFeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var internetDetection: InternetDetection?
    
    let cellID = "APODEntryCell"
    
    var entries = [APODEntryModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(APODEntryCell.self, forCellReuseIdentifier: cellID)
        
        internetDetection = InternetDetection(parentVC: self)
        internetDetection?.startMonitoringInternetConnection()
        
        //APODEntries = APODEntryMethods().getPastEntries(amount: 10)
        
        //entryCellInsertionManager.addNextEntryToPageUnlessNoEntriesExist(allAPODEntries: allAPODEntries, tableView: tableView)
        tableView.allowsSelection = false
        //tableView.reloadData()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //entryCellInsertionManager.loadMoreEntriesWhenSrollReachesBottom(tableView: tableView, allAPODEntries: allAPODEntries, isConnected: internetDetection!.isConnected!)
    }

}

extension APODFeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(entries[indexPath.row].cellHeight!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! APODEntryCell
        let entry = entries[indexPath.row]
        
        cell.delegate = self
        cell.index = indexPath.row
        EntryCellConstructor().assignCell(cell: cell, entry: entry, tableView: tableView, parent: self)
    
        return cell
    }
    
}

extension APODFeedVC: APODEntryCellDelegate {
    func didTapExpandButton(index: Int, cell: APODEntryCell) {
        let results = ExpandExplanationManager().toggleExplanationExpansion(entry: entries[index], cell: cell)
        entries[index].expandEnabled = results.0
        entries[index].cellHeight = results.1
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
