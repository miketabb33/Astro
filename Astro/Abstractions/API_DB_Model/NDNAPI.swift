import Foundation
import Alamofire
import SwiftyJSON
import CoreData

class NDNAPI {
    lazy var persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    func getTodaysNasaEntry() {
        Alamofire.request("https://ndn-api.herokuapp.com/", method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let nasaJSON = JSON(response.result.value!)
                let backgroundContext = self.persistentContainer.newBackgroundContext()
                backgroundContext.perform {
                    let todaysEntry = NasaEntry(context: backgroundContext)
                    todaysEntry.date = nasaJSON["items"][0]["date"].stringValue
                    todaysEntry.explanation = nasaJSON["items"][0]["explanation"].stringValue
                    todaysEntry.title = nasaJSON["items"][0]["title"].stringValue
                    todaysEntry.url = nasaJSON["items"][0]["url"].stringValue
                    
                    self.attemptToSaveContext(backgroundContext)
                }
                
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    func attemptToSaveContext(_ backgroundContext: NSManagedObjectContext) {
        do {
            try backgroundContext.save()
        } catch {
            print("error preloading data: \(error)")
        }
    }
}
