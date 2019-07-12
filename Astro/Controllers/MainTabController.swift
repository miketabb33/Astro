import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class MainTabController: UITabBarController {
    let nasaDataHandler = NasaDataHandler()
    let planetDataHandler = PlanetDataHandler()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    var container = [Planets]()
    var nasaEntries = [NasaEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //select which tab is displayed upon opening app.
        selectedViewController = self.viewControllers?[2]
        
        nasaDataHandler.sendNasaDailyNewsDataToView(viewControllers?[1])
        
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
                    
                    let request : NSFetchRequest<NasaEntry> = NasaEntry.fetchRequest()
                    
                    do {
                        self.nasaEntries = try self.context.fetch(request)
                        print(self.nasaEntries)
                    } catch {
                        print("Error fetching data from context \(error)")
                    }
                }
                
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        planetDataHandler.sendPlanetDataToViews(firstView: viewControllers?[0] as? UINavigationController, secondView: viewControllers?[2])
    }
    
    func attemptToSaveContext(_ backgroundContext: NSManagedObjectContext) {
        do {
            try backgroundContext.save()
        } catch {
            print("error preloading data: \(error)")
        }
    }
}
