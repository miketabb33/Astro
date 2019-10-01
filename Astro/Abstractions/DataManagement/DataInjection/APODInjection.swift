import Foundation
import Alamofire
import SwiftyJSON

class APODInjection {
    let realmMethods = RealmMethods()
    let userDefaultsMethods = UserDefaultsMethods()
    
    lazy var url = "https://ndn-api.herokuapp.com?id=\(Keys().NDN_KEY)"
    
    func updateAPODEntries(initialUploadCompleted: Bool) {
        Alamofire.request(url, method: .get).responseJSON {
            response in
            
            if response.result.isSuccess {
                let jsonData = JSON(response.result.value!)
                let stagedEntries = self.digestAPODData(data: jsonData)
                
                self.saveEntries(initialUploadCompleted: initialUploadCompleted, stagedEntries: stagedEntries)
                
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    func saveEntries(initialUploadCompleted: Bool, stagedEntries: [APODEntry]) {
        if initialUploadCompleted {
            saveLatestUnsavedEntries(stagedEntries: stagedEntries)
        } else {
            saveAllEntries(stagedEntries: stagedEntries)
        }
    }
    
    func saveAllEntries(stagedEntries: [APODEntry]) {
        realmMethods.addAPOD(data: stagedEntries)
        userDefaultsMethods.setUserDefaults(data: true, key: userDefaultsMethods.initialAPODUploadCompletedKey)
        print("Initial APOD Upload Complete")
    }
    
    func saveLatestUnsavedEntries(stagedEntries: [APODEntry]) {
        let unsavedEntries = self.getUnsavedEntries(stagedEntries: stagedEntries)
        realmMethods.addAPOD(data: unsavedEntries)
        print("\(unsavedEntries.count) new APOD entries saved")
    }
    
    func getUnsavedEntries(stagedEntries: [APODEntry]) -> [APODEntry] {
        let lastestEntry = realmMethods.getLastAPODEntry()
        var unsavedEntries = [APODEntry]()
        
        for currentEntry in stagedEntries {
            if currentEntry.title != lastestEntry.title {
                unsavedEntries.append(currentEntry)
            } else {
                break
            }
        }
        
        return unsavedEntries
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
