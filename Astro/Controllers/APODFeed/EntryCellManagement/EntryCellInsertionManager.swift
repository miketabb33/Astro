import UIKit
import RealmSwift

class EntryCellInsertionManager {
//    var showingEntries = 0
//    var initialEntryCount = 5
//    var initialEntryLoadComplete = false
//    
//    let entriesToAdd = 1
//    
//    //MARK: - Inital Entry Load
//    func addNextEntryToPageUnlessNoEntriesExist(allAPODEntries: [APODEntryModel], tableView: UITableView) {
//        if allAPODEntries.count != 0 {
//            addNextEntryToPageUnlessInitialLoadComplete(tableView: tableView)
//        }
//    }
//    
//    func addNextEntryToPageUnlessInitialLoadComplete(tableView: UITableView) {
//        if !initialEntryLoadComplete {
//            performInitialEntryLoad(tableView: tableView)
//        }
//    }
//    
//    func performInitialEntryLoad(tableView: UITableView) {
//        if showingEntries < initialEntryCount {
//            showingEntries = showingEntries + 1
//            DispatchQueue.main.async {
//                tableView.reloadData()
//            }
//        } else {
//            initialEntryLoadComplete = true
//        }
//    }
//    
//    //MARK: - Load More Entries on scroll
//    func loadMoreEntriesWhenSrollReachesBottom(tableView: UITableView, allAPODEntries: [APODEntryModel], isConnected: Bool) {
//        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) && showingEntries < allAPODEntries.count {
//            insertNextSetOfRows(tableView: tableView, allAPODEntries: allAPODEntries, isConnected: isConnected)
//        }
//    }
//    
//    func insertNextSetOfRows(tableView: UITableView, allAPODEntries: [APODEntryModel], isConnected: Bool) {
//        tableView.beginUpdates()
//        var i = 0
//        var totalEntries = showingEntries
//        var shouldLoadNext = true
//        
//        while i < entriesToAdd && totalEntries < allAPODEntries.count && shouldLoadNext {
//            if allAPODEntries[showingEntries + i].image != nil {
//                tableView.insertRows(at: [IndexPath(row: showingEntries + i, section: 0)], with: .fade)
//                i = i + 1
//                totalEntries = totalEntries + 1
//            } else if allAPODEntries[showingEntries + i].image == nil && isConnected {
//                tableView.insertRows(at: [IndexPath(row: showingEntries + i, section: 0)], with: .fade)
//                i = i + 1
//                totalEntries = totalEntries + 1
//            } else {
//                shouldLoadNext = false
//            }
//        }
//        
//        showingEntries = showingEntries + i
//        tableView.endUpdates()
//    }
//    
}
