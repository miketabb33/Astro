import UIKit

class NasaNewsEntryManager {
    var showingEntries = 1
    var totalEntriesOnPage = 4
    
    let incrementTotalEntriesOnPage = 4
    
    func addNextEntryToPage(tableView: UITableView) {
        if showingEntries < totalEntriesOnPage {
            showingEntries = showingEntries + 1
            tableView.reloadData()
            print("yoooo")
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
    
}
