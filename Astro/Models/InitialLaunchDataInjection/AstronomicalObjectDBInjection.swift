import Foundation

class AstronomicalObjectDBInjection {
    let userDefaultMethods = UserDefaultsMethods()
    
    func uploadAstronomicalObjectsUnlessCompleted() {
        if !userDefaultMethods.getUserDefaultsForBoolean(key: userDefaultMethods.astronomicalObjectPreloadCompletedKey) {
            uploadAstronomicalObjectData()
        }
    }
    
    func uploadAstronomicalObjectData() {
        guard let AstronomicalObjectURLPath = Bundle.main.url(forResource: "AstronomicalObjectData", withExtension: "plist") else {
            fatalError("Unableto find astronomical object data path")
        }

        if let AstronomicalObjectFileData = try? Data(contentsOf: AstronomicalObjectURLPath) {
            let decoder = PropertyListDecoder()
            do {
                let results = try decoder.decode([AstroObjUploadModel].self, from: AstronomicalObjectFileData)
                RealmMethods().createSetOfAstonomicalObjects(set: results)
                
                userDefaultMethods.setUserDefaults(data: true, key: userDefaultMethods.astronomicalObjectPreloadCompletedKey)
                
            } catch {
                print("Error decoding planet info plist: \(error)")
            }
        }
    }
}

