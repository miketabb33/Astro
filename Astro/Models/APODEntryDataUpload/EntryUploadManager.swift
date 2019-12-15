import Foundation

class EntryUploadManager {
    var isUploading = false
    
    func saveImagesAndCellHeight(startingFrom startingIndex: Int, amount: Int, completion: (([APODEntryModel]) -> ())?) {
        DispatchQueue.global(qos: .background).async {
            self.isUploading = true
            let entries = APODEntryMethods().getPastEntries(startingFrom: startingIndex, amount: amount)
            let entriesWithImages = EntryImageNetworking().getImagesAndCellHeightForAPODEntries(entries)
            
            APODEntryMethods().saveCollectionOfImageDataAndCellHeight(entries: entriesWithImages)
            
            completion?(entriesWithImages)
            self.isUploading = false
        }
    }

}
