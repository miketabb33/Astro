import UIKit
import Alamofire
import SwiftyJSON

class MainTabController: UITabBarController {
    
    var nasaDataModel = NasaDataModel()
    
    let api_key = "O5XtjFT6wV1o5zLwNDhhwf8giPbWhlasYL24H69p"
    let api_url = "https://api.nasa.gov/planetary/apod"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNasaData()
        
        //select which tab is displayed upon opening app.
        self.selectedViewController = self.viewControllers?[2]
        
    }
    
    //MARK - load current nasa information
    
    func loadNasaData() {
        let params : [String : String] = ["api_key" : api_key]
        
        getNasaData(url: api_url, parameters: params)
    }
    
    //MARK - Networking
    
    func getNasaData(url: String, parameters: [String : String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let nasaJSON : JSON = JSON(response.result.value!)
                self.updateNasaData(json: nasaJSON)
            } else {
                print("Error \(String(describing: response.result.error))")
                //self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    //MARK - Json parsing
    func updateNasaData(json: JSON) {
        //print(json)
        
        nasaDataModel.title = json["title"].stringValue
        nasaDataModel.description = json["explanation"].stringValue
        nasaDataModel.imageURL = json["url"].stringValue
        nasaDataModel.date = json["date"].stringValue
        
        updateModelWithImageData()
    }
    
    
    
    func updateModelWithImageData(){
        let imageUrlString = nasaDataModel.imageURL
        let imageUrl:URL = URL(string: imageUrlString)!
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            
            DispatchQueue.main.async {
                self.nasaDataModel.imageData = UIImage(data: imageData as Data)
                print("Picture loaded into Nasa Data Model")
                let nasaDailyNewsView = self.viewControllers?[1] as! NasaDailyNewsVC
                nasaDailyNewsView.nasaDataModel = self.nasaDataModel
                nasaDailyNewsView.nasaDataLoadedTrigger = self.nasaDataModel.imageData
            }
        }
    }
    
    
    
    

//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }

}
