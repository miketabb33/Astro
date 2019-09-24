import Foundation
import Alamofire
import SwiftyJSON
import CoreData

class NDNAPI {
    let persistantData = PersistentData()
    let key = Keys()
    
    lazy var url = "https://ndn-api.herokuapp.com?id=\(key.NDN_KEY)"
    
    let userDefaults = UserDefaults.standard
    
    func uploadDeviceWithNasaEntries() {
        if userDefaults.bool(forKey: persistantData.initialAPODUploadCompletedKey) {
            getRecentNasaEntry()
        } else {
            initialNasaEntryUpload()
        }
    }
    
    func initialNasaEntryUpload() {
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let rawData = JSON(response.result.value!)
                let stagedData = self.digestAPODData(data: rawData)
                
                self.persistantData.addAPOD(data: stagedData)
                
                self.persistantData.setUserDefaults(data: true, key: self.persistantData.initialAPODUploadCompletedKey)
                print("Initial Nasa Entry Upload Complete")
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    
    func getRecentNasaEntry() {
        Alamofire.request(url, method: .get).responseJSON {
            response in
            
            if response.result.isSuccess {
                let rawData = JSON(response.result.value!)
                let stagedData = self.digestAPODData(data: rawData)
                
                let lastLocalNasaEntry = self.persistantData.getLastLocalNasaEntry()
                
                for currentEntry in stagedData {
                    if currentEntry.title != lastLocalNasaEntry[0].title! {
//                        self.persistantData.insertDataIntoDatabase(stagedNasaData: [currentEntry])
                        print("Latest nasa entries inserted into database")
                    } else {
                        break
                    }
                }
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    func digestAPODData(data: JSON) -> [APODEntry] {
        let numberOfFetchedItems = data["totalItems"].intValue
        var APODEntries = [APODEntry]()
        var i = 0
        
        while i < numberOfFetchedItems {
            let currentEntry = APODEntry()
            currentEntry.date = data["items"][i]["date"].stringValue
            currentEntry.explanation = decodeString(string: data["items"][i]["explanation"].stringValue)
            currentEntry.title = decodeString(string: data["items"][i]["title"].stringValue)
            currentEntry.url = data["items"][i]["url"].stringValue
            APODEntries.append(currentEntry)
            i = i + 1
        }
        return APODEntries
    }
    
    func decodeString(string: String) -> String {
        let data = string.data(using: .utf8)!
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            fatalError("NDN-API data did not decode correctly")
        }
        
        return attributedString.string
    }
    
}
