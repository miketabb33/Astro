import UIKit

class APODFeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var internetDetection: InternetDetection?
    var infiniteScroll: InfiniteScroll?
    
    let LoadingCellID = "LoadingCell"
    let APODTableViewCellID = "APODTableViewCell"
    
    var entries = [APODEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        infiniteScroll = InfiniteScroll(parentVC: self)
        
        internetDetection = InternetDetection(parentVC: self)
        internetDetection?.startMonitoringInternetConnection()
        
        //entries = APODEntryBuilder().getLastLoadedAPODEntries(amount: 10)
        
        updateTableWithNewEntriesWhenReady()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let currentHeight = scrollView.contentOffset.y
        let frameHeight = scrollView.frame.size.height
        
        infiniteScroll!.beginDownloadingImageDataForNextEntrySet(percentageToBottom: 0.5, currentHeight: currentHeight, contentHeight: contentHeight)
        
        infiniteScroll!.displayNextEntrySetWhenReady(distanceFromBottom: 700, currentHeight: currentHeight, contentHeight: contentHeight, scrollViewFrameHeight: frameHeight)
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
        
        cell.setCellData(entry: entry, index: indexPath.row, delegate: self)
        
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

extension APODFeedVC {
    func updateTableWithNewEntriesWhenReady() {
        Notifier().await(onComplete: completeUpload, updateConditional: updateConditional)
    }
    
    func completeUpload() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.entryImageNetworking = nil
        
        entries = APODEntryBuilder().getAPODEntries(startingIndex: 0, amount: FeedSettings().amountToShow)
        tableView.reloadData()
    }
    
    func updateConditional() -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.entryImageNetworking!.entriesFinishedUploading
    }
    
}

