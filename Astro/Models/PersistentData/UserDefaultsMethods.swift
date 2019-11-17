import UIKit

class UserDefaultsMethods {
    let astronomicalObjectPreloadCompletedKey = "Astronomical-Object-Preload-Completed"
    
    func setUserDefaults(data: Any, key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func getUserDefaultsForBoolean(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
}
