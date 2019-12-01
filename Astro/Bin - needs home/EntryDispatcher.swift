import UIKit

class EntryDispatcher {
    func dispatchEntriesToFeed(entries: [APODEntryModel]) {
        DispatchQueue.main.async {
            let rootVC = UIApplication.shared.windows.first!.rootViewController as! MainTabController
            let feedVC = rootVC.viewControllers?[1] as! APODFeedVC
            feedVC.entries = entries
            if feedVC.tableView != nil {
                feedVC.tableView.reloadData()
            }
        }
    }
}
