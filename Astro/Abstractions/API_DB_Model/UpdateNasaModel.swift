import Foundation
import SwiftyJSON

class UpdateNasaModel {
    let nasaData = NasaDataModel()
    
    func updateModelWithNasaData(json: JSON, completion: @escaping () -> Void) {
        nasaData.title = json["title"].stringValue
        nasaData.description = json["explanation"].stringValue
        nasaData.imageURL = json["url"].stringValue
        nasaData.date = json["date"].stringValue
        
        updateModelWithImageData(completion: completion)
    }
    
    func updateModelWithImageData(completion: @escaping () -> Void){
//
//        self.nasaData.imageData = UIImage(named: "superwide")
//        completion()
        
        
        
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
