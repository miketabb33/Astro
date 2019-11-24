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
                let results = try decoder.decode(APODEntriesJSONModel.self, from: safeData)
                addUnsavedAPODEntries(results)
            } catch {
                print("Error decoding NDN-API Response")
            }
        }
    }
    
    func addUnsavedAPODEntries(_ results: APODEntriesJSONModel) {
        let lastSavedEntryID = APODEntryMethods().getLastID()
        for result in results.entries {
            let resultID = Int(result.id)!
            let resultTitle = DecoderMethods().decodeWithUTF8(string: result.title)
            let resultExplanation = DecoderMethods().decodeWithUTF8(string: result.explanation)
            let resultDate = FormatterMethods().convertToDate(yyyyMMdd: result.date)
            
            if resultID > lastSavedEntryID {
                APODEntryMethods().create(id: Int(result.id)!, title: resultTitle, explanation: resultExplanation, date: resultDate, imageURL: result.image_url)
            } else {
                break
            }
        }
    }
    
}
