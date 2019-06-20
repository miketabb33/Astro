import Foundation
import SwiftyJSON

class FetchNasaDailyNewsData {
    let nasaData = NasaDataModel()
    
    let api_key = "O5XtjFT6wV1o5zLwNDhhwf8giPbWhlasYL24H69p"
    let api_url = "https://api.nasa.gov/planetary/apod"

    
    //MARK - Json parsing
    func updateModelWithNasaData(json: JSON, completion: @escaping () -> Void) {
        nasaData.title = json["title"].stringValue
        nasaData.description = json["explanation"].stringValue
        nasaData.imageURL = json["url"].stringValue
        nasaData.date = json["date"].stringValue
        
        updateModelWithImageData(completion: completion)
    }
    
    func updateModelWithImageData(completion: @escaping () -> Void){
        let imageUrlString = nasaData.imageURL
        let imageUrl:URL = URL(string: imageUrlString)!
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            
            DispatchQueue.main.async {
                self.nasaData.imageData = UIImage(data: imageData as Data)
                completion()
            }
        }
    }
    
}
