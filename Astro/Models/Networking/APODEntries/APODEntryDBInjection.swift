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
                let results = try decoder.decode(APODEntriesUploadModel.self, from: safeData)
                addUnsavedAPODEntries(results)
            } catch {
                print("Error decoding NDN-API Response")
            }
        }
    }
    
    func addUnsavedAPODEntries(_ results: APODEntriesUploadModel) {
        let lastSavedEntryID = APODEntryMethods().getLastID()
        for result in results.entries {
            if Int(result.id)! > lastSavedEntryID {
                APODEntryMethods().create(id: Int(result.id)!, title: result.title, explanation: result.explanation, date: result.date, imageURL: result.image_url)
            } else {
                break
            }
        }
    }
    
}
