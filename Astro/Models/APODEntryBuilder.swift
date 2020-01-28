import Foundation

class APODEntryBuilder {
    func getAPODEntries(startingIndex: Int, amount: Int) -> [APODEntry] {
        let heights = StaticElementHeights()
        let entriesRealm = APODEntryCRUD().getAll()
        var entries = [APODEntry]()
         
        var i = 0
        while i < amount && startingIndex + i < entriesRealm.count {
            let entry = entriesRealm[i + startingIndex]
            
            let feedDataRealm = APODFeedDataCRUD().get(id: entry.id)!
            
            let contents = Contents(title: entry.title, explanation: entry.explanation, date: entry.date, image_url: entry.image_url)
            
            let cellHeight = CellHeight(title: heights.title, image: feedDataRealm.imageHeight, explanation: heights.explanation, expandButtonView: heights.expandButtonView)
            
            let feedData = FeedData(image: feedDataRealm.image, cellHeight: cellHeight)
            
            entries.append(APODEntry(id: entry.id, contents: contents, feedData: feedData))
             
            i += 1
        }
        return entries
    }
    
}
