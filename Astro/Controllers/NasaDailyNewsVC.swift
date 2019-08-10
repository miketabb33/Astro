import UIKit

class NasaDailyNewsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    
    let persistentData = PersistentData()
    let nasaNewsEntryManager = NasaNewsEntryManager()
    let UIProcessing = NDNVCProcessing()
    let addConstraints = UIConstraints()
    let internetConnection = InternetConnection()
    
    var allNasaEntries = [NasaEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(NasaNewsEntryCell.self, forCellReuseIdentifier: "CustomNasaNewsEntryCell")
        tableView.rowHeight = 450
        
        internetConnection.startMonitoringInternetConnection()
        internetConnection.assignComponents(messageLabel: messageLabel, parentView: self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        allNasaEntries = persistentData.getAllNasaEntries()
        nasaNewsEntryManager.addNextEntryToPageUnlessNoEntriesExist(allNasaEntries: allNasaEntries, tableView: tableView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        nasaNewsEntryManager.loadMoreEntriesWhenSrollReachesBottom(tableView: tableView, allNasaEntries: allNasaEntries, isConnected: internetConnection.isConnected)
    }

}

extension NasaDailyNewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nasaNewsEntryManager.showingEntries
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(allNasaEntries[indexPath.row].cellHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomNasaNewsEntryCell", for: indexPath) as! NasaNewsEntryCell
        
        if allNasaEntries[indexPath.row].image == nil {
            if allNasaEntries[indexPath.row].url!.suffix(3) != "jpg" {
                nasaNewsEntryManager.saveAsYoutubeImage(indexPath: indexPath, allNasaEntries: allNasaEntries)
                assignCell(cell: cell, indexPath: indexPath)
                nasaNewsEntryManager.addNextEntryToPageUnlessInitialLoadComplete(tableView: tableView)
            } else {
                let imageUrlString = allNasaEntries[indexPath.row].url!
                let imageUrl:URL = URL(string: imageUrlString)!
                let imageData:NSData = NSData(contentsOf: imageUrl)!
                allNasaEntries[indexPath.row].image = imageData as Data
                persistentData.saveNasaEntries()
                assignCell(cell: cell, indexPath: indexPath)
                nasaNewsEntryManager.addNextEntryToPageUnlessInitialLoadComplete(tableView: tableView)
            }
        } else {
            assignCell(cell: cell, indexPath: indexPath)
            nasaNewsEntryManager.addNextEntryToPageUnlessInitialLoadComplete(tableView: tableView)
        }
        
        return cell
    }
    
}

extension NasaDailyNewsVC {
    func assignCell(cell: NasaNewsEntryCell, indexPath: IndexPath) {
        cell.currentEntryTitle.text = allNasaEntries[indexPath.row].title
        addConstraints.addConstraintForTopMostElementTo(cell.currentEntryTitle, topAnchor: cell.contentView.topAnchor, edges: cell.contentView.layoutMarginsGuide, height: cell.frameHeight["title"]!)
        
        cell.currentEntryImageView.image = UIImage(data: allNasaEntries[indexPath.row].image!)
        cell.currentEntryImageView = UIProcessing.processImage(currentCell: cell, stackUnder: cell.currentEntryTitle, edges: cell.contentView.safeAreaLayoutGuide)
        
        cell.currentEntryExplanation.text = allNasaEntries[indexPath.row].explanation
        if allNasaEntries[indexPath.row].expandEnabled == true {
            cell.currentExpandExplanationButton.transform = CGAffineTransform(rotationAngle: .pi)
            cell.currentEntryExplanation.numberOfLines = 0
            cell.currentEntryExplanation.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.currentEntryExplanation.sizeToFit()
            self.addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: cell.currentEntryExplanation.frame.height)
        } else {
            cell.currentExpandExplanationButton.transform = .identity
            cell.currentEntryExplanation.numberOfLines = 7
            cell.currentEntryExplanation.lineBreakMode = NSLineBreakMode.byTruncatingTail
            self.addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: cell.frameHeight["explanation"]!)
        }
        
        addConstraints.addStackingConstraintForButton(cell.currentExpandExplanationButton, stackUnder: cell.currentEntryExplanation, width: cell.frameHeight["button"]!, height: cell.frameHeight["button"]!, parentView: self.view)
        
        cell.didTapExpandButton = {
            if self.allNasaEntries[indexPath.row].expandEnabled == false {
                UIView.animate(withDuration: 0.5) {
                    cell.currentExpandExplanationButton.transform = CGAffineTransform(rotationAngle: .pi)
                }
                self.allNasaEntries[indexPath.row].expandEnabled = true
                cell.currentEntryExplanation.numberOfLines = 0
                cell.currentEntryExplanation.lineBreakMode = NSLineBreakMode.byWordWrapping
                cell.currentEntryExplanation.sizeToFit()
                self.addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: cell.currentEntryExplanation.frame.height)
                self.allNasaEntries[indexPath.row].cellHeight = Float(cell.frameHeight["title"]! + cell.frameHeight["image"]! + cell.currentEntryExplanation.frame.height + cell.frameHeight["button"]!)
                self.persistentData.saveNasaEntries()
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            } else {
                UIView.animate(withDuration: 0.5) {
                    cell.currentExpandExplanationButton.transform = .identity
                }
                self.allNasaEntries[indexPath.row].expandEnabled = false
                cell.currentEntryExplanation.numberOfLines = 7
                cell.currentEntryExplanation.lineBreakMode = NSLineBreakMode.byTruncatingTail
                self.addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: cell.frameHeight["explanation"]!)
                self.allNasaEntries[indexPath.row].cellHeight = Float(cell.frameHeight["title"]! + cell.frameHeight["image"]! + cell.frameHeight["explanation"]! + cell.frameHeight["button"]!)
                self.persistentData.saveNasaEntries()
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            }
            
        }
        
        if allNasaEntries[indexPath.row].cellHeight == 0 {
            allNasaEntries[indexPath.row].cellHeight = Float(cell.frameHeight["title"]! + cell.frameHeight["image"]! + cell.frameHeight["explanation"]! + cell.frameHeight["button"]!)
            persistentData.saveNasaEntries()
        }
        
    }
}
