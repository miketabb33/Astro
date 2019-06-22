import Foundation
import Alamofire
import SwiftyJSON

class APIRequest {
    func getData(api_url: String, api_key: String, action: @escaping (JSON, @escaping () -> Void) -> (), completion: @escaping () -> Void) {
        Alamofire.request(api_url, method: .get, parameters: ["api_key" : api_key]).responseJSON {
            response in
            self.dataHandler(response, action: action, completion: completion)
        }
    }
    
    func dataHandler(_ response: DataResponse<Any>, action: @escaping (JSON, @escaping () -> Void) -> (), completion: @escaping () -> Void) {
        if response.result.isSuccess {
            let nasaJSON = JSON(response.result.value!)
            action(nasaJSON, completion)
        } else {
            print("Error \(String(describing: response.result.error))")
        }
    }
}
