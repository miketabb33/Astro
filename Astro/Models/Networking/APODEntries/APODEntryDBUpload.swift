import UIKit // switch to foundation after class bottom class removal

class APODEntryDBUpload {
    func SyncronizeAPODEntries() {
        let urlString = "https://ndn-api.herokuapp.com?id=\(Keys().APOD_API_KEY)"
        let url = URL(string: urlString)!
        let session = URLSession(configuration: .default)
        let dataTask = NetworkManager().createDataTask(session: session, url: url, onSuccess: decodeDataAndUpdateRealm)
        dataTask.resume()
    }
    
    func decodeDataAndUpdateRealm(data: Data?) {
        let decoder = JSONDecoder()
        if let safeData = data {
            do {
                let results = try decoder.decode(APODEntriesJSONModel.self, from: safeData)
                addUnsavedAPODEntriesAndDispatchToFeed(results)
            } catch {
                print("Error decoding NDN-API Response")
            }
        }
    }
    
    func addUnsavedAPODEntriesAndDispatchToFeed(_ results: APODEntriesJSONModel) {
        let lastSavedEntryID = APODEntryMethods().getLastID()
        let newAPODEntryDispatcher = NewAPODEntryDispatcher()
        
        for result in results.entries {
            let resultID = Int(result.id)!
            let resultTitle = DecoderMethods().decodeWithUTF8(string: result.title)
            let resultExplanation = DecoderMethods().decodeWithUTF8(string: result.explanation)
            let resultDate = FormatterMethods().convertToDate(yyyyMMdd: result.date)
            
            let newEntry = APODEntryModel(id: resultID, title: resultTitle, explanation: resultExplanation, date: resultDate, image_url: result.image_url)
            if resultID > lastSavedEntryID {
                APODEntryMethods().create(id: newEntry.id, title: newEntry.title, explanation: newEntry.explanation, date: newEntry.date, imageURL: newEntry.image_url)
                newAPODEntryDispatcher.observeAndDispatch()
            } else {
                newAPODEntryDispatcher.sendAPODEntriesToFeed()
                break
            }
        }
    }
}

class NewAPODEntryDispatcher {
    var limit = 0
    var APODEntriesDispatched = false
    
    func observeAndDispatch() {
        if limit < 10 {
            limit += 1
        } else if limit == 10 && !APODEntriesDispatched {
            sendAPODEntriesToFeed()
            APODEntriesDispatched = true
        }
    }
    
    func sendAPODEntriesToFeed() {
        DispatchQueue.global(qos: .background).async {
            let entries = APODEntryMethods().getPastEntries(amount: 10)
            
            let entriesWithImages = APODImages().getImagesForAPODEntries(entries)
            
            APODEntryMethods().saveCollectionOfImageDataAndCellHeight(entries: entriesWithImages)
            
            DispatchQueue.main.async {
                let rootVC = UIApplication.shared.windows.first!.rootViewController as! MainTabController
                let feedVC = rootVC.viewControllers?[1] as! APODFeedVC
                feedVC.APODEntries = entriesWithImages
            }
        }
    }
}

class APODImages {
    func getImagesForAPODEntries(_ entries: [APODEntryModel]) -> [APODEntryModel] {
        var entriesWithImages = [APODEntryModel]()

        for entry in entries {
            if entry.image == nil {
                var cellHeight = Int()
                var image: Data?
                if entry.image_url.suffix(3) != "jpg" {
                    image = UIImage(named: "youtube")!.pngData()
                    cellHeight = getCellHeight(imageData: image)
                } else {
                    let imageUrl:URL = URL(string: entry.image_url)!
                    let imageData:NSData = NSData(contentsOf: imageUrl)!
                    image = imageData as Data
                    cellHeight = getCellHeight(imageData: image)
                }
                entriesWithImages.append(APODEntryModel(id: entry.id, title: entry.title, explanation: entry.explanation, date: entry.date, image_url: entry.image_url, image: image, cellHeight: cellHeight, expandEnabled: false))
            } else {
                entriesWithImages.append(APODEntryModel(id: entry.id, title: entry.title, explanation: entry.explanation, date: entry.date, image_url: entry.image_url, image: entry.image, cellHeight: entry.cellHeight, expandEnabled: false))
            }
            
            
        }
        
        return entriesWithImages
    }
    
    func getCellHeight(imageData: Data?) -> Int {
        let image = UIImage(data: imageData!)
        let imageHeight = getImageDisplayHeight(image: image!)
        return Int(50 + imageHeight + 120 + 20)
    }
    
    func getImageDisplayHeight(image: UIImage) -> CGFloat {
        let width = image.size.width
        let height = image.size.height
        let ratio = width/height
        
        let screenWidth = UIScreen.main.bounds.width
        let aspectHeight = (screenWidth/width) * height
        
        if ratio >= 1.25 {
            return aspectHeight
        } else if ratio <= 0.75 {
            return screenWidth
        } else {
            return screenWidth
        }
        
    }
}
