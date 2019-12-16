import UIKit

class EntryImageNetworking {
    
    var isUploading = false
    
    func saveImagesAndCellHeight(startingFrom startingIndex: Int, amount: Int, completion: (([APODEntryModel]) -> ())?) {
        DispatchQueue.global(qos: .background).async {
            self.isUploading = true
            let entries = APODEntryMethods().getPastEntries(startingFrom: startingIndex, amount: amount)
            let entriesWithImages = self.getImagesAndCellHeightForAPODEntries(entries)
            
            APODEntryMethods().saveCollectionOfImageDataAndCellHeight(entries: entriesWithImages)
            
            completion?(entriesWithImages)
            self.isUploading = false
        }
    }
    
    func getImagesAndCellHeightForAPODEntries(_ entries: [APODEntryModel]) -> [APODEntryModel] {
        return entries.map { (entry) -> APODEntryModel in
            if entry.image == nil {
                let image = getImage(url: entry.image_url)
                let cellHeight = getCellHeight(imageData: image)
                return APODEntryModel(id: entry.id, title: entry.title, explanation: entry.explanation, date: entry.date, image_url: entry.image_url, image: image, cellHeight: cellHeight)
            } else {
                return entry
            }
        }
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
