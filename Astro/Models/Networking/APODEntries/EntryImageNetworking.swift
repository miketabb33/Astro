import UIKit

class EntryImageNetworking {
    
    var isFinishedUploading = false
    
    func saveImagesAndCellHeight(startingIndex: Int, amount: Int) {
        DispatchQueue.global(qos: .background).async {
            let imageURLs = APODEntryInteraction().getImageURLs(startingIndex: startingIndex, amount: amount)
            let feedDataUpload = self.getImagesAndCellHeight(imageURLs: imageURLs)
            
            APODFeedDataInteraction().create(feedDataUpload)
            
            self.isFinishedUploading = true
        }
    }
    
    func getImagesAndCellHeight(imageURLs: [(Int, String)]) -> [APODFeedDataUpload] {
        var APODFeedDataUploadGroup = [APODFeedDataUpload]()
        
        for imageURL in imageURLs {
            let entryID = imageURL.0
            let feedData = APODFeedDataInteraction().get(id: entryID)
            
            if feedData == nil {
                let image = getImage(url: imageURL.1)
                let cellHeight = getCellHeight(imageData: image)
                APODFeedDataUploadGroup.append(APODFeedDataUpload(id: entryID, image: image, cellHeight: cellHeight))
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
    
    func getCellHeight(imageData: Data?) -> Int {
        let componantHeight = APODEntryComponentDefaultHeights()
        
        let image = UIImage(data: imageData!)
        let imageHeight = ImageProcessing(image: image!).getImageDisplayHeight()
        return Int(componantHeight.title + imageHeight + componantHeight.explanation + componantHeight.button)
    }
}
