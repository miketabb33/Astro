import UIKit

class APODFeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var internetDetection: InternetDetection?
    
    //let APODEntryCellID = "APODEntryCell"
    let LoadingCellID = "LoadingCell"
    let APODTableViewCellID = "APODTableViewCell"
    
    var entries = [APODEntry]()
    
    var feedManager = FeedManager()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.register(APODEntryCell.self, forCellReuseIdentifier: APODEntryCellID)
        
        tableView.register(UINib(nibName: APODTableViewCellID, bundle: nil), forCellReuseIdentifier: APODTableViewCellID)
        
        tableView.register(LoadingCell.self, forCellReuseIdentifier: LoadingCellID)
        
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
        return CGFloat(300+20+50+120)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: APODTableViewCellID, for: indexPath) as! APODTableViewCell
        let entry = entries[indexPath.row]

        cell.APODImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        cell.titleLabel.text = entry.contents.title
        
        let image = UIImage(data: entry.feedData.image)!
        cell.APODImageView.image = image
        cell.APODImageView.contentMode = ImageProcessing(image: image).getContentMode()
        
        
        cell.explanationLabel.text = entry.contents.explanation
        
        cell.delegate = self
        cell.index = indexPath.row
        
        //EntryCellConstructor().assignCell(cell: cell, entry: entry, tableView: tableView, parent: self)
    
        return cell
    }
    
}

extension APODFeedVC: APODTableViewCellDelegate {
    func didTapExpandButton(cell: APODTableViewCell) {
//        let results = ExpandExplanationManager().toggleExplanationExpansion(entry: entries[index], cell: cell)
//        entries[index].feedData.expandEnabled = results.0
//        entries[index].feedData.cellHeight = results.1
//        tableView.beginUpdates()
//        tableView.endUpdates()
    }
}

