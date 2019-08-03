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
    func addNextEntryToPageUnlessInitialLoadComplete(tableView: UITableView) {
        if !initialEntryLoadComplete {
            performInitialEntryLoad(tableView: tableView)
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
    func loadMoreEntriesWhenSrollReachesBottom(tableView: UITableView, allNasaEntries: [NasaEntry]) {
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) && showingEntries < allNasaEntries.count {
            insertNextSetOfRows(tableView: tableView, allNasaEntries: allNasaEntries)
        }
    }
    
    func insertNextSetOfRows(tableView: UITableView, allNasaEntries: [NasaEntry]) {
        if showingEntries <= allNasaEntries.count {
            tableView.beginUpdates()
            insertNextRowUnlessNoMoreRowsToAdd(tableView: tableView, allNasaEntries: allNasaEntries)
            tableView.endUpdates()
        }
    }
    
    
    func insertNextRowUnlessNoMoreRowsToAdd(tableView: UITableView, allNasaEntries: [NasaEntry]) {
        var i = 0
        var limiter = showingEntries
        while i < entriesToAdd && limiter < allNasaEntries.count {
            tableView.insertRows(at: [IndexPath(row: showingEntries + i, section: 0)], with: .automatic)
            i = i + 1
            limiter = limiter + 1
        }
        showingEntries = showingEntries + i
    }
    
}
