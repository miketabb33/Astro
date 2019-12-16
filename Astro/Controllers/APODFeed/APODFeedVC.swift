import UIKit

class APODFeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var internetDetection: InternetDetection?
    
    let APODEntryCellID = "APODEntryCell"
    
    var entries = [APODEntry]()
    
    var feedManager = FeedManager()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(APODEntryCell.self, forCellReuseIdentifier: APODEntryCellID)
        
        internetDetection = InternetDetection(parentVC: self)
        internetDetection?.startMonitoringInternetConnection()
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (timer) in
            if self.appDelegate.entryImageNetworking.isFinishedUploading {
                self.entries = APODEntryBuilder().getAPODEntries(startingIndex: 0, amount: 10)
                self.tableView.reloadData()
                timer.invalidate()
            } else {
                //Loading
            }
        }
        //entries = APODEntryMethods().getPastEntries(amount: 10)

        tableView.allowsSelection = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let currentHeight = scrollView.contentOffset.y
        let frameHeight = scrollView.frame.size.height
        
        feedManager.beginDownloadingImageDataForNextEntrySet(currentHeight: currentHeight, contentHeight: contentHeight)
        
        feedManager.scrollDidApproachBottom(currentHeight: currentHeight, contentHeight: contentHeight, scrollViewFrameHeight: frameHeight, parentVC: self)
    
    }

}

extension APODFeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(entries[indexPath.row].feedData.cellHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: APODEntryCellID, for: indexPath) as! APODEntryCell
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
        entries[index].feedData.expandEnabled = results.0
        entries[index].feedData.cellHeight = results.1
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

