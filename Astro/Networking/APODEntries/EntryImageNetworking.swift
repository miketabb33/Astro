import UIKit

class EntryImageNetworking {
    
    var entriesFinishedUploading = false
    
    func saveImagesAndCellHeight(startingIndex: Int, amount: Int) {
        DispatchQueue.global(qos: .background).async {
            let imageURLs = APODEntryInteraction().getImageURLs(startingIndex: startingIndex, amount: amount)
            let feedDataUpload = self.getImagesAndCellHeight(imageURLs: imageURLs)
            
            APODFeedDataInteraction().create(feedDataUpload)
            
            self.entriesFinishedUploading = true
        }
    }
    
    func getImagesAndCellHeight(imageURLs: [(Int, String)]) -> [APODFeedDataUpload] {
        var APODFeedDataUploadGroup = [APODFeedDataUpload]()
        
        for imageURL in imageURLs {
            let entryID = imageURL.0
            let feedData = APODFeedDataInteraction().get(id: entryID)
            
            if feedData == nil {
                let imageData = getImage(url: imageURL.1)
                let imageHeight = getImageHeight(imageData: imageData)
                let cellHeight = getCellHeight(imageHeight: imageHeight)
                APODFeedDataUploadGroup.append(APODFeedDataUpload(id: entryID, image: imageData, imageHeight: imageHeight, cellHeight: cellHeight))
            }
        }
        
        return APODFeedDataUploadGroup
    }

    func getImage(url: String) -> Data {
        if url.suffix(3) != "jpg" && url.suffix(3) != "png" {
            return UIImage(named: "youtube")!.pngData()!
        } else {
            let imageUrl = URL(string: url)!
            let imageData = NSData(contentsOf: imageUrl)!
            return imageData as Data
        }
    }
    
    func getImageHeight(imageData: Data?) -> Int {
        let image = UIImage(data: imageData!)
        let imageHeight = ImageProcessing(image: image!).getImageDisplayHeight()
        return Int(imageHeight)
    }
    
    func getCellHeight(imageHeight: Int) -> Int {
        let componentHeight = APODEntryComponentDefaultHeights()
        
        let cellHeight = Int(componentHeight.title) + Int(componentHeight.explanation) + Int(componentHeight.expandButtonView) + imageHeight
        return cellHeight
    }
}
