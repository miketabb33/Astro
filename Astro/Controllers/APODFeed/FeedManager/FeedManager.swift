import UIKit

class FeedManager {
    var additionalImagesPending = false
    
    var approachedBottom = false
    
    var nextStartingIndex = FeedSettings().amountToShow
    
    let entryImageNetworking = EntryImageNetworking()
    
    func beginDownloadingImageDataForNextEntrySet(currentHeight: CGFloat, contentHeight: CGFloat) {
        let ratio = currentHeight / contentHeight
        
        if ratio > 0.1 && !additionalImagesPending {
            additionalImagesPending = true
            entryImageNetworking.saveImagesAndCellHeight(startingIndex: nextStartingIndex, amount: FeedSettings().amountToShow)
        }
    }
    
    func scrollDidApproachBottom(currentHeight: CGFloat, contentHeight: CGFloat, scrollViewFrameHeight: CGFloat, parentVC: APODFeedVC) {
        let distanceToLoadNextImage: CGFloat = 1000
        
        let topOfScreen = contentHeight - scrollViewFrameHeight
        
        if currentHeight > topOfScreen - distanceToLoadNextImage && !approachedBottom {
            approachedBottom = true
            
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (timer) in
                if self.entryImageNetworking.entriesFinishedUploading {
                    timer.invalidate()
                    
                    let nextGroup = APODEntryBuilder().getAPODEntries(startingIndex: self.nextStartingIndex, amount: FeedSettings().amountToShow)
                    parentVC.entries.append(contentsOf: nextGroup)
                    parentVC.tableView.reloadData()
                    
                    self.additionalImagesPending = false
                    self.approachedBottom = false
                    self.entryImageNetworking.entriesFinishedUploading = false
                    
                    self.nextStartingIndex += FeedSettings().amountToShow
                    
                } else {
                    //Loading
                    
                }
            }
        }
    }
}
