import UIKit

class UserDefaultsMethods {
    let astroObjUploadCompletedKey = "Astronomical-Object-Preload-Completed"
    
    func setUserDefaults(data: Any, key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func getBoolean(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
}
