import UIKit

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
                newAPODEntryDispatcher.collectEntriesAndDispatch(entry: newEntry)
            } else {
                newAPODEntryDispatcher.sendAPODEntriesToFeed()
                break
            }
        }
    }
}

class NewAPODEntryDispatcher {
    var container = [APODEntryModel]()
    var APODEntriesDispatched = false
    
    func collectEntriesAndDispatch(entry: APODEntryModel) {
        if container.count < 10 {
            container.append(APODEntryModel(id: entry.id, title: entry.title, explanation: entry.title, date: entry.date, image_url: entry.image_url))
        } else if container.count == 10 && !APODEntriesDispatched {
            sendAPODEntriesToFeed()
            APODEntriesDispatched = true
        }
    }
    
    func sendAPODEntriesToFeed() {
        DispatchQueue.main.async {
            let rootVC = UIApplication.shared.windows.first!.rootViewController as! MainTabController
            let feedVC = rootVC.viewControllers?[1] as! APODFeedVC
            feedVC.APODEntries = self.container
        }
    }
}
