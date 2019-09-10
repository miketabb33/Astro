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
        if userDefaults.bool(forKey: persistantData.initialNasaEntryUploadCompletedKey) {
            getRecentNasaEntry()
        } else {
            initialNasaEntryUpload()
        }
    }
    
    func initialNasaEntryUpload() {
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let fetchedNasaData = JSON(response.result.value!)
                let stagedNasaData = self.digestNasaDataIntoArray(nasaData: fetchedNasaData)
                self.persistantData.insertDataIntoDatabase(stagedNasaData: stagedNasaData)
                self.userDefaults.set(true, forKey: self.persistantData.initialNasaEntryUploadCompletedKey)
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
                let fetchedNasaData = JSON(response.result.value!)
                let stagedNasaData = self.digestNasaDataIntoArray(nasaData: fetchedNasaData)
                
                let lastLocalNasaEntry = self.persistantData.getLastLocalNasaEntry()
                
                for currentEntry in stagedNasaData {
                    if currentEntry.title != lastLocalNasaEntry[0].title! {
                        self.persistantData.insertDataIntoDatabase(stagedNasaData: [currentEntry])
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
    
    func digestNasaDataIntoArray(nasaData: JSON) -> [NDNAPIStagingModel] {
        let numberOfFetchedItems = nasaData["totalItems"].intValue
        var stagedNasaData = [NDNAPIStagingModel]()
        var i = 0
        
        while i < numberOfFetchedItems {
            let currentNasaEntry = NDNAPIStagingModel()
            currentNasaEntry.date = nasaData["items"][i]["date"].stringValue
            currentNasaEntry.explanation = nasaData["items"][i]["explanation"].stringValue
            currentNasaEntry.title = nasaData["items"][i]["title"].stringValue
            currentNasaEntry.url = nasaData["items"][i]["url"].stringValue
            stagedNasaData.append(currentNasaEntry)
            i = i + 1
        }
        
        return stagedNasaData
    }

}
