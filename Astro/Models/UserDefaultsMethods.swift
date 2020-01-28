import UIKit

class UserDefaultsMethods {
    let astroObjUploadCompletedKey = "Astronomical-Object-Preload-Completed"
    let domain = UserDefaults.standard
    
    func setUserDefaults(data: Any, key: String) {
        domain.set(data, forKey: key)
    }
    
    func getBoolean(key: String) -> Bool {
        return domain.bool(forKey: key)
    }
}
