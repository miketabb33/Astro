import UIKit

class APODFeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var internetDetection: InternetDetection?
    
    let LoadingCellID = "LoadingCell"
    let APODTableViewCellID = "APODTableViewCell"
    
    var entries = [APODEntry]()
    
    var feedManager = FeedManager()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        internetDetection = InternetDetection(parentVC: self)
        internetDetection?.startMonitoringInternetConnection()
        
        entries = APODEntryBuilder().getLastLoadedAPODEntries(amount: 10)
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (timer) in
            if self.appDelegate.entryImageNetworking.entriesFinishedUploading {
                self.entries = APODEntryBuilder().getAPODEntries(startingIndex: 0, amount: 10)
                self.tableView.reloadData()
                timer.invalidate()
            } else {
                //Loading
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let currentHeight = scrollView.contentOffset.y
        let frameHeight = scrollView.frame.size.height
        
        feedManager.beginDownloadingImageDataForNextEntrySet(currentHeight: currentHeight, contentHeight: contentHeight)
        
        feedManager.scrollDidApproachBottom(currentHeight: currentHeight, contentHeight: contentHeight, scrollViewFrameHeight: frameHeight, parentVC: self)
    
    }
    
    func configureTableView() {
        tableView.register(UINib(nibName: APODTableViewCellID, bundle: nil), forCellReuseIdentifier: APODTableViewCellID)
        tableView.register(LoadingCell.self, forCellReuseIdentifier: LoadingCellID)
        tableView.allowsSelection = false
    }

}

extension APODFeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return CGFloat(entries[indexPath.row].feedData.cellHeight)
//        let imageHeight = entries[indexPath.row].feedData.imageHeight
//
//        return CGFloat(50 + imageHeight + 120 + 20)
        
        
        
        return CGFloat(entries[indexPath.row].feedData.cellHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: APODTableViewCellID, for: indexPath) as! APODTableViewCell
        var entry = entries[indexPath.row]
        
        cell.setCellData(entry: entry)
        
        entry.feedData.cellHeight = Int((cell.cellHeight?.getCellHeight())!)
        
        cell.delegate = self
        cell.index = indexPath.row
    
        return cell
    }
    
}

extension APODFeedVC: APODTableViewCellDelegate {
    func didTapExpandButton(cell: APODTableViewCell) {
        
        cell.cellHeight?.explanationHeight = 300
        entries[cell.index!].feedData.cellHeight = Int((cell.cellHeight?.getCellHeight())!)
//        let results = ExpandExplanationManager().toggleExplanationExpansion(entry: entries[cell.index!], cell: cell)
//        entries[cell.index!].feedData.expandEnabled = results.0
//        entries[cell.index!].feedData.cellHeight = results.1
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

