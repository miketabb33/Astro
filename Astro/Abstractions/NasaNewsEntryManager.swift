import UIKit

class NasaNewsEntryManager {
    let persistentData = PersistentData()
    let loadingAnimation = LoadingAnimation()
    
    var showingEntries = 0
    var initialEntryCount = 5
    var initialLoadComplete = false
    
    let entriesToAdd = 1
    
    
    func addNextEntryToPageUnlessInitialLoadComplete(tableView: UITableView) {
        if !initialLoadComplete {
            if showingEntries < initialEntryCount {
                showingEntries = showingEntries + 1
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            } else {
                initialLoadComplete = true
                loadingAnimation.hide()
            }
        }
        
    }
    
    func loadMoreEntriesWhenSrollReachesBottom(tableView: UITableView, allNasaEntries: [NasaEntry]) {
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) && showingEntries < allNasaEntries.count {
            print("scroll event triggered")
            if showingEntries <= allNasaEntries.count {
                tableView.beginUpdates()
                var i = 0
                var limiter = showingEntries
                
                while i < entriesToAdd && limiter < allNasaEntries.count {

                    tableView.insertRows(at: [IndexPath(row: showingEntries + i, section: 0)], with: .automatic)
                    i = i + 1
                    limiter = limiter + 1
                }
                
                showingEntries = showingEntries + i
                tableView.endUpdates()
            }
        }
    }

    
    func saveAsYoutubeImage(indexPath: IndexPath, allNasaEntries: [NasaEntry]) {
        allNasaEntries[indexPath.row].image = UIImage(named: "youtube")!.pngData()
        persistentData.saveNasaEntries()
    }
    
}
