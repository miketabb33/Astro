import Foundation

class EntryNetworking {
    
    var imagesReadyForDownload = false
    
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
                let results = try decoder.decode(EntriesNetworkModel.self, from: safeData)
                addUnsavedAPODEntriesAndDispatchToFeed(results)
            } catch {
                print("Error decoding NDN-API Response")
            }
        }
    }
    
    func addUnsavedAPODEntriesAndDispatchToFeed(_ results: EntriesNetworkModel) {
        let lastSavedEntryID = APODEntryInteraction().getLastID()
        
        let results = results.entries
        
        var index = 0
        
        while index < results.count && Int(results[index].id)! > lastSavedEntryID {
            print("result:", results[index].id)
            APODEntryInteraction().create(entry: results[index])
            imagesReadyForDownload = imageDownloadReadyChecker(numberOfNewEntries: index)
            index += 1
        }
        imagesReadyForDownload = true
    }
    
    func imageDownloadReadyChecker(numberOfNewEntries: Int) -> Bool {
        if numberOfNewEntries >= FeedSettings().amountToShow {
            return true
        } else {
            return false
        }
    }
    
    
}


