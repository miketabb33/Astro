import Foundation

class AppLaunchEntryManager {
    let initialEntryDispatchCount = 10
    
    func addUnsavedAPODEntriesAndDispatchToFeed(_ results: APODEntriesJSONModel) {
        let lastSavedEntryID = APODEntryMethods().getLastID()
        let results = results.entries
        
        var index = 0
        var entriesDispatched = false
        
        let currentResultIsntSaved = Int(results[index].id)! > lastSavedEntryID
        
        while index < results.count && currentResultIsntSaved {
            APODEntryMethods().create(entry: results[index])
            entriesDispatched = saveImageDataUnlessAmountToSmall(amount: index, isDispatched: entriesDispatched)
            index += 1
        }
        saveImageDataAndDispatch(isDispatched: entriesDispatched)
    }
    
    func saveImageDataUnlessAmountToSmall(amount: Int, isDispatched: Bool) -> Bool {
        var dispatched = false
        if amount >= initialEntryDispatchCount {
            saveImageDataAndDispatch(isDispatched: isDispatched)
            dispatched = true
        }
        return dispatched
    }
    
    func saveImageDataAndDispatch(isDispatched: Bool) {
        if !isDispatched {
            EntryUploadManager().saveImagesAndCellHeight(startingFrom: 0, amount: initialEntryDispatchCount, completion: EntryDispatcher().dispatchEntriesToFeed(entries:))
        }
    }
    
    
    
}
