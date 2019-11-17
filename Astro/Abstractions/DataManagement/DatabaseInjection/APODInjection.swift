import Foundation

class APODInjection {
    let realmMethods = RealmMethods()
    
    func SyncronizeAPODEntries() {
        let urlString = "https://ndn-api.herokuapp.com?id=\(Keys().APOD_API_KEY)"
        let url = URL(string: urlString)!
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error in NDN_API request: \(error)")
            } else {
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let results = try decoder.decode(APODItemsModel.self, from: safeData)
                        let lastSavedEntryID = RealmMethods().getLastAPODEntryID()
                        
                        for result in results.entries {
                            if Int(result.id)! > lastSavedEntryID {
                                let stagedEntry = APODEntryRealm()
                                stagedEntry.id = Int(result.id)!
                                stagedEntry.title = self.decodeWithUTF8(string: result.title)
                                stagedEntry.explanation = self.decodeWithUTF8(string: result.explanation)
                                stagedEntry.date = result.date
                                stagedEntry.image_url = result.image_url
                                RealmMethods().addAPODEntry(entry: stagedEntry)
                            } else {
                                break
                            }
        
                        }
                        
                    
                    } catch {
                        print("Error decoding NDN-API Response")
                    }
                    
                }
            }
        }
        
        dataTask.resume()
    }
    

    func decodeWithUTF8(string: String) -> String {
        let data = string.data(using: .utf8)!

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            fatalError("APOD-API data did not decode correctly")
        }

        return attributedString.string
    }
    
}
