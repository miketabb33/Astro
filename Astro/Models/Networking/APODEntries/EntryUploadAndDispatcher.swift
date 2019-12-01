import UIKit

class EntryUploadAndDispatcher {
    var limit = 0
    var APODEntriesDispatched = false
    
    func addUnsavedAPODEntriesAndDispatchToFeed(_ results: APODEntriesJSONModel) {
        let lastSavedEntryID = APODEntryMethods().getLastID()
        
        for result in results.entries {
            let resultID = Int(result.id)!
            let resultTitle = DecoderMethods().decodeWithUTF8(string: result.title)
            let resultExplanation = DecoderMethods().decodeWithUTF8(string: result.explanation)
            let resultDate = FormatterMethods().convertToDate(yyyyMMdd: result.date)
            
            let newEntry = APODEntryModel(id: resultID, title: resultTitle, explanation: resultExplanation, date: resultDate, image_url: result.image_url)
            
            if resultID > lastSavedEntryID {
                APODEntryMethods().create(id: newEntry.id, title: newEntry.title, explanation: newEntry.explanation, date: newEntry.date, imageURL: newEntry.image_url)
                observeAndDispatch()
            } else {
                sendAPODEntriesToFeed()
                break
            }
        }
    }
    
    func observeAndDispatch() {
        if limit < 10 {
            limit += 1
        } else if limit == 10 && !APODEntriesDispatched {
            sendAPODEntriesToFeed()
            APODEntriesDispatched = true
        }
    }
    
    func sendAPODEntriesToFeed() {
        DispatchQueue.global(qos: .background).async {
            let entries = APODEntryMethods().getPastEntries(amount: 10)
            
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
