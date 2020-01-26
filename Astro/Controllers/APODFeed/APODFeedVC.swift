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
        
        //entries = APODEntryBuilder().getLastLoadedAPODEntries(amount: 10)
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (timer) in
            if self.appDelegate.entryImageNetworking.entriesFinishedUploading {
                self.entries = APODEntryBuilder().getAPODEntries(startingIndex: 0, amount: FeedSettings().amountToShow)
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
        return entries[indexPath.row].feedData.cellHeight.total()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: APODTableViewCellID, for: indexPath) as! APODTableViewCell
        let entry = entries[indexPath.row]
        
        cell.setCellData(entry: entry)
        
        cell.delegate = self
        cell.index = indexPath.row
    
        return cell
    }
    
}

extension APODFeedVC: APODTableViewCellDelegate {
    func didTapExpandButton(index: Int, explanationLabel: UILabel, expandButton: UIButton, explanationHeightConstraint: NSLayoutConstraint) {
        entries[index].feedData.cellHeight.explanation = ExpandExplanationManager().toggle(isExpanded: entries[index].feedData.expandEnabled, label: explanationLabel, button: expandButton)
        
        explanationHeightConstraint.constant = entries[index].feedData.cellHeight.explanation
        
        entries[index].feedData.expandEnabled = entries[index].feedData.expandEnabled == true ? false : true
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

