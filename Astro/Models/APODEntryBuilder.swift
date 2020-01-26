import Foundation

class APODEntryBuilder {
    func getAPODEntries(startingIndex: Int, amount: Int) -> [APODEntry] {
        let heights = StaticElementHeights()
        let entriesRealm = APODEntryInteraction().getAll()
        var entries = [APODEntry]()
         
        var i = 0
        while i < amount && startingIndex + i < entriesRealm.count {
            let entry = entriesRealm[i + startingIndex]
            
            let feedDataRealm = APODFeedDataInteraction().get(id: entry.id)!
            
            let contents = Contents(title: entry.title, explanation: entry.explanation, date: entry.date, image_url: entry.image_url)
            
            let cellHeight = CellHeight(title: heights.title, image: feedDataRealm.imageHeight, explanation: heights.explanation, expandButtonView: heights.expandButtonView)
            
            let feedData = FeedData(image: feedDataRealm.image, cellHeight: cellHeight)
            
            entries.append(APODEntry(id: entry.id, contents: contents, feedData: feedData))
             
            i += 1
        }
        return entries
    }
    
    
    
    
//    func getLastLoadedAPODEntries(amount: Int) -> [APODEntry] {
//        var entries = [APODEntry]()
//        let feedDataRealm = APODFeedDataInteraction().getAll()
//
//        var i = 0
//        while i < amount && i < feedDataRealm.count {
//
//            let feedData = feedDataRealm[i]
//
//            let entryRealm = APODEntryInteraction().get(id: feedData.id)!
//
//            let contents = Contents(title: entryRealm.title, explanation: entryRealm.explanation, date: entryRealm.date, image_url: entryRealm.image_url)
//            let feed = FeedData(image: feedData.image, imageHeight: feedData.cellHeight, cellHeight: feedData.cellHeight)
//
//            entries.append(APODEntry(id: feedData.id, contents: contents, feedData: feed))
//
//            i += 1
//        }
//        return entries
//    }
}
