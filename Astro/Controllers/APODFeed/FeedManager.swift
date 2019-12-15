import UIKit

class FeedManager {
    var additionalImagesPending = false
    
    var approachedBottom = false
    
    var amountToShow = AppLaunchEntryManager().initialEntryDispatchCount
    var nextStartingIndex = AppLaunchEntryManager().initialEntryDispatchCount
    
    let uploadManager = EntryUploadManager()
    
    func beginDownloadingImageDataForNextEntrySet(currentHeight: CGFloat, contentHeight: CGFloat) {
        let ratio = currentHeight / contentHeight
        
        if ratio > 0.1 && !additionalImagesPending {
            additionalImagesPending = true
            uploadManager.saveImagesAndCellHeight(startingFrom: nextStartingIndex, amount: amountToShow, completion: nil)
        }
    }
    
    func scrollDidApproachBottom(currentHeight: CGFloat, contentHeight: CGFloat, scrollViewFrameHeight: CGFloat, parentVC: APODFeedVC) {
        let amountBeforeBottom: CGFloat = 1000
        
        let topOfScreen = contentHeight - scrollViewFrameHeight
        
        if currentHeight > topOfScreen - amountBeforeBottom && !approachedBottom {
            approachedBottom = true
            
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (timer) in
                if self.uploadManager.isUploading {
                    //Loading
                    print("Loading")
                } else {
                    timer.invalidate()
                    
                    let nextGroup = APODEntryMethods().getPastEntries(startingFrom: self.nextStartingIndex, amount: self.amountToShow)
                    parentVC.entries.append(contentsOf: nextGroup)
                    parentVC.tableView.reloadData()
                    
                    self.additionalImagesPending = false
                    self.approachedBottom = false
                    
                    self.nextStartingIndex += 10
                }
            }
        }
    }
}
