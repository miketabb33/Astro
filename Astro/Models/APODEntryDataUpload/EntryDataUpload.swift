import Foundation

class EntryDataUpload {
    let initialEntryDispatchCount = 10
    
    func addUnsavedAPODEntriesAndDispatchToFeed(_ results: APODEntriesJSONModel) {
        let lastSavedEntryID = APODEntryMethods().getLastID()
        let results = results.entries
        
        var index = 0
        var entriesDispatched = false
        
        let currentResultIsntSaved = Int(results[index].id)! > lastSavedEntryID
        
        while index < results.count && currentResultIsntSaved {
            let newEntry = createAPODEntryModelWithUTF8(from: results[index])
            APODEntryMethods().create(from: newEntry)
            entriesDispatched = dispatchEntrieUnlessAmountToSmallOrDispatched(amount: index, isDispatched: entriesDispatched)
            index += 1
        }
        dispatchEntriesUnlessDispatched(isDispatched: entriesDispatched)
    }
    
    func dispatchEntrieUnlessAmountToSmallOrDispatched(amount: Int, isDispatched: Bool) -> Bool {
        var dispatched = false
        if amount >= initialEntryDispatchCount {
            dispatchEntriesUnlessDispatched(isDispatched: isDispatched)
            dispatched = true
        }
        return dispatched
    }
    
    func dispatchEntriesUnlessDispatched(isDispatched: Bool) {
        if !isDispatched {
            EntryDispatcher().sendAPODEntriesToFeed(amount: initialEntryDispatchCount)
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
