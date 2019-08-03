import UIKit

class NasaNewsEntryManager {
    let persistentData = PersistentData()
    
    var showingEntries = 0
    var totalEntriesOnPage = 4
    
    let incrementTotalEntriesOnPage = 4
    
    func addNextEntryToPage(tableView: UITableView) {
        if showingEntries < totalEntriesOnPage {
            showingEntries = showingEntries + 1
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
    func loadMoreEntriesWhenSrollReachesBottom(tableView: UITableView, allNasaEntries: [NasaEntry]) {
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) && showingEntries < allNasaEntries.count {
            addToShowingEntriesUpToCeiling(allNasaEntries: allNasaEntries)
            addNextEntryToPage(tableView: tableView)
        }
    }
    
    func addToShowingEntriesUpToCeiling(allNasaEntries: [NasaEntry]) {
        totalEntriesOnPage = totalEntriesOnPage + incrementTotalEntriesOnPage
        if totalEntriesOnPage > allNasaEntries.count {
            totalEntriesOnPage = allNasaEntries.count
        }
    }
    
    func saveAsYoutubeImage(indexPath: IndexPath, allNasaEntries: [NasaEntry]) {
        allNasaEntries[indexPath.row].image = UIImage(named: "youtube")!.pngData()
        persistentData.saveNasaEntries()
    }
    
}
