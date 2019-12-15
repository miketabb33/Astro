import Foundation

class EntryDataUploadManager {
    let initialEntryDispatchCount = 10
    
    var isUploading = false
    
    func addUnsavedAPODEntriesAndDispatchToFeed(_ results: APODEntriesJSONModel) {
        let lastSavedEntryID = APODEntryMethods().getLastID()
        let results = results.entries
        
        var index = 0
        var entriesDispatched = false
        
        let currentResultIsntSaved = Int(results[index].id)! > lastSavedEntryID
        
        while index < results.count && currentResultIsntSaved {
            let newEntry = createAPODEntryModelWithUTF8(from: results[index])
            APODEntryMethods().create(from: newEntry)
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
            saveImagesAndCellHeight(startingFrom: 0, amount: initialEntryDispatchCount, completion: EntryDispatcher().dispatchEntriesToFeed(entries:))
        }
    }
    
    func saveImagesAndCellHeight(startingFrom startingIndex: Int, amount: Int, completion: (([APODEntryModel]) -> ())?) {
        DispatchQueue.global(qos: .background).async {
            self.isUploading = true
            let entries = APODEntryMethods().getPastEntries(startingFrom: startingIndex, amount: amount)
            let entriesWithImages = EntryImageNetworking().getImagesAndCellHeightForAPODEntries(entries)
            
            APODEntryMethods().saveCollectionOfImageDataAndCellHeight(entries: entriesWithImages)
            
            completion?(entriesWithImages)
            self.isUploading = false
        }
    }
    
    func createAPODEntryModelWithUTF8(from entry: APODEntryJSONModel) -> APODEntryModel {
        let resultID = Int(entry.id)!
        let resultTitle = DecoderMethods().decodeWithUTF8(string: entry.title)
        let resultExplanation = DecoderMethods().decodeWithUTF8(string: entry.explanation)
        let resultDate = FormatterMethods().convertToDate(yyyyMMdd: entry.date)
        
        return APODEntryModel(id: resultID, title: resultTitle, explanation: resultExplanation, date: resultDate, image_url: entry.image_url)
    }
}
