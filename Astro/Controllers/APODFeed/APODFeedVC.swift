import UIKit

class APODFeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var internetDetection: InternetDetection?
    
    let cellID = "APODEntryCell"
    
    var entries = [APODEntryModel]()
    
    var additionalImagesPending = false
    
    var hitBottom = false
    
    var amountToShow = 10
    var nextIndex = 0
    
    let uploadManager = EntryDataUploadManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(APODEntryCell.self, forCellReuseIdentifier: cellID)
        
        internetDetection = InternetDetection(parentVC: self)
        internetDetection?.startMonitoringInternetConnection()
        
        //entries = APODEntryMethods().getPastEntries(amount: 10)

        tableView.allowsSelection = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let currentHeight = scrollView.contentOffset.y
        
        let ratio = currentHeight / contentHeight
        
        if ratio > 0.5 && !additionalImagesPending {
            additionalImagesPending = true
            nextIndex += 10
            uploadManager.saveImagesAndCellHeight(startingFrom: nextIndex, amount: amountToShow, completion: nil)
        }
        
        if currentHeight > contentHeight - scrollView.frame.size.height && !hitBottom {
            hitBottom = true
            
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (timer) in
                if self.uploadManager.isUploading {
                    //Loading
                    print("Loading")
                } else {
                    timer.invalidate()
                    
                    let nextGroup = APODEntryMethods().getPastEntries(startingFrom: self.nextIndex, amount: self.amountToShow)
                    self.entries.append(contentsOf: nextGroup)
                    self.tableView.reloadData()
                    
                    self.additionalImagesPending = false
                    self.hitBottom = false
                }
            }
            
        }
    
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

