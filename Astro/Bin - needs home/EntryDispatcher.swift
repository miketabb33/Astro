import UIKit

class EntryDispatcher {
    func sendAPODEntriesToFeed(amount: Int) {
        DispatchQueue.global(qos: .background).async {
            let entries = APODEntryMethods().getPastEntries(amount: amount)
            
            let entriesWithImages = EntryImageNetworking().getImagesAndCellHeightForAPODEntries(entries)
            
            APODEntryMethods().saveCollectionOfImageDataAndCellHeight(entries: entriesWithImages)
            
            DispatchQueue.main.async {
                let rootVC = UIApplication.shared.windows.first!.rootViewController as! MainTabController
                let feedVC = rootVC.viewControllers?[1] as! APODFeedVC
                feedVC.entries = entriesWithImages
                if feedVC.tableView != nil {
                    feedVC.tableView.reloadData()
                }
            }
        }
    }
}
