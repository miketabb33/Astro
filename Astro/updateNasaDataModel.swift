import Foundation
import Alamofire
import SwiftyJSON


class updateNasaDataModel {
    
    var nasaDataModel = NasaDataModel()
    
    let api_key = "O5XtjFT6wV1o5zLwNDhhwf8giPbWhlasYL24H69p"
    let api_url = "https://api.nasa.gov/planetary/apod"
    
    func getNasaData(completion: @escaping (Bool) -> Void) {
        Alamofire.request(api_url, method: .get, parameters: ["api_key" : api_key]).responseJSON {
            response in
            var nasaJSON : JSON = "no data"
            if response.result.isSuccess {
                nasaJSON = JSON(response.result.value!)
                self.updateModelWithNasaData(json: nasaJSON, completion: completion)
            } else {
                print("Error \(String(describing: response.result.error))")
                //self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    //MARK - Json parsing
    func updateModelWithNasaData(json: JSON, completion: @escaping (Bool) -> Void) {
        //print(json)
        
        nasaDataModel.title = json["title"].stringValue
        nasaDataModel.description = json["explanation"].stringValue
        nasaDataModel.imageURL = json["url"].stringValue
        nasaDataModel.date = json["date"].stringValue
        
        updateModelWithImageData(completion: completion)
    }
    
    func updateModelWithImageData(completion: @escaping (Bool) -> Void){
        let imageUrlString = nasaDataModel.imageURL
        let imageUrl:URL = URL(string: imageUrlString)!
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            
            DispatchQueue.main.async {
                self.nasaDataModel.imageData = UIImage(data: imageData as Data)
                completion(true)
            }
        }
    }
    
    
    
    
}
