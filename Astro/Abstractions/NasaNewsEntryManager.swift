import UIKit

class NasaNewsEntryManager {
    let persistentData = PersistentData()
    let loadingAnimation = LoadingAnimation()
    
    var showingEntries = 0
    var initialEntryCount = 5
    var initialEntryLoadComplete = false
    
    let entriesToAdd = 1
    
    func saveAsYoutubeImage(indexPath: IndexPath, allNasaEntries: [NasaEntry]) {
        allNasaEntries[indexPath.row].image = UIImage(named: "youtube")!.pngData()
        persistentData.saveNasaEntries()
    }
    
    
    //MARK: - Inital Entry Load
    func addNextEntryToPageUnlessNoEntriesExist(allNasaEntries: [NasaEntry], tableView: UITableView) {
        if allNasaEntries.count != 0 {
            addNextEntryToPageUnlessInitialLoadComplete(tableView: tableView)
        }
    }
    
    func addNextEntryToPageUnlessInitialLoadComplete(tableView: UITableView) {
        if !initialEntryLoadComplete {
            performInitialEntryLoad(tableView: tableView)
        }  else {
            loadingAnimation.hide()
        }
    }
    
    func performInitialEntryLoad(tableView: UITableView) {
        if showingEntries < initialEntryCount {
            showingEntries = showingEntries + 1
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        } else {
            initialEntryLoadComplete = true
            loadingAnimation.hide()
        }
    }
    
    //MARK: - Load More Entries on scroll
    func loadMoreEntriesWhenSrollReachesBottom(tableView: UITableView, allNasaEntries: [NasaEntry], isConnected: Bool) {
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) && showingEntries < allNasaEntries.count {
            insertNextSetOfRows(tableView: tableView, allNasaEntries: allNasaEntries, isConnected: isConnected)
        }
    }
    
    func insertNextSetOfRows(tableView: UITableView, allNasaEntries: [NasaEntry], isConnected: Bool) {
        tableView.beginUpdates()
        var i = 0
        var totalEntries = showingEntries
        var shouldLoadNext = true
        
        while i < entriesToAdd && totalEntries < allNasaEntries.count && shouldLoadNext {
            if allNasaEntries[showingEntries + i].image != nil {
                tableView.insertRows(at: [IndexPath(row: showingEntries + i, section: 0)], with: .fade)
                i = i + 1
                totalEntries = totalEntries + 1
            } else if allNasaEntries[showingEntries + i].image == nil && isConnected {
                tableView.insertRows(at: [IndexPath(row: showingEntries + i, section: 0)], with: .fade)
                i = i + 1
                totalEntries = totalEntries + 1
            } else {
                shouldLoadNext = false
            }
        }
        
        showingEntries = showingEntries + i
        tableView.endUpdates()
    }
    
}
