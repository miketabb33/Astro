import UIKit

class NasaNewsEntryManager {
    var showingEntries = 10
    var entriesToAdd = 10
    
    func loadMoreEntriesWhenSrollReachesBottom(tableView: UITableView, allNasaEntries: [NasaEntry]) {
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) && showingEntries < allNasaEntries.count {
            showingEntries = addToShowingEntriesUpToCeiling(allNasaEntries: allNasaEntries)
            DispatchQueue.main.async {
                tableView.reloadData()
            }
            
        }
    }
    
    func addToShowingEntriesUpToCeiling(allNasaEntries: [NasaEntry]) -> Int {
        showingEntries = showingEntries + entriesToAdd
        if showingEntries > allNasaEntries.count {
            showingEntries = allNasaEntries.count
        }
        return showingEntries
    }
    
}
