import Foundation

class APODEntryBuilder {
    func getAPODEntries(startingIndex: Int, amount: Int) -> [APODEntry] {
        let APODEntries = APODEntryInteraction().getAll()
        var entries = [APODEntry]()
         
        var i = 0
        while i < amount && startingIndex + i < APODEntries.count {
            let entry = APODEntries[i + startingIndex]
            
            let contents = Contents(title: entry.title, explanation: entry.explanation, date: entry.date, image_url: entry.image_url)
            let feedData = FeedData(image: entry.image!, cellHeight: entry.cellHeight)
            
            entries.append(APODEntry(id: entry.id, contents: contents, feedData: feedData))
             
            i += 1
        }
        return entries
    }
}
