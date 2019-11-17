import Foundation

class APODEntryDBInjection {
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
                let results = try decoder.decode(APODEntriesModel.self, from: safeData)
                addUnsavedAPODEntries(results)
            } catch {
                print("Error decoding NDN-API Response")
            }
        }
    }
    
    func addUnsavedAPODEntries(_ results: APODEntriesModel) {
        let lastSavedEntryID = RealmMethods().getLastSavedAPODEntryID()
        for result in results.entries {
            if Int(result.id)! > lastSavedEntryID {
                RealmMethods().createAPODEntry(apodEntry: result)
            } else {
                break
            }
        }
    }
    
}
