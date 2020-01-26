import UIKit

class InfiniteScroll {
    var parentVC: APODFeedVC
    
    init(parentVC: APODFeedVC) {
        self.parentVC = parentVC
    }
    
    var additionalImagesPending = false
    var approachedBottom = false
    var nextStartingIndex = FeedSettings().amountToShow
    
    let entryImageNetworking = EntryImageNetworking()
    
    func beginDownloadingImageDataForNextEntrySet(percentageToBottom: CGFloat, currentHeight: CGFloat, contentHeight: CGFloat) {
        let ratio = currentHeight / contentHeight
        
        if ratio > percentageToBottom && !additionalImagesPending {
            additionalImagesPending = true
            entryImageNetworking.saveImagesAndCellHeight(startingIndex: nextStartingIndex, amount: FeedSettings().amountToShow)
        }
    }
    
    func displayNextEntrySetWhenReady(distanceFromBottom: CGFloat, currentHeight: CGFloat, contentHeight: CGFloat, scrollViewFrameHeight: CGFloat) {
        
        let topOfScreen = contentHeight - scrollViewFrameHeight
        
        if currentHeight > topOfScreen - distanceFromBottom && !approachedBottom {
            approachedBottom = true
            
            LoadNewEntriesWhenReady()
        }
    }
    
}


extension InfiniteScroll {
    func LoadNewEntriesWhenReady() {
        InternalNetworking().listen(onComplete: completeLoad, updateConditional: updateConditional)
    }
    
    func completeLoad() {
        let nextEntrySet = APODEntryBuilder().getAPODEntries(startingIndex: self.nextStartingIndex, amount: FeedSettings().amountToShow)
        parentVC.entries.append(contentsOf: nextEntrySet)
        parentVC.tableView.reloadData()
        
        additionalImagesPending = false
        approachedBottom = false
        entryImageNetworking.entriesFinishedUploading = false
        
        nextStartingIndex += FeedSettings().amountToShow
    }
    
    func updateConditional() -> Bool {
        return entryImageNetworking.entriesFinishedUploading
    }
}
