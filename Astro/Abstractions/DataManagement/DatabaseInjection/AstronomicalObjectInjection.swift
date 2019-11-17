import Foundation

class AstronomicalObjectInjection {
    let userDefaultMethods = UserDefaultsMethods()
    
    func preloadAstronomicalObjectsUnlessCompleted() {
        if !userDefaultMethods.getUserDefaultsForBoolean(key: userDefaultMethods.astronomicalObjectPreloadCompletedKey) {
            preloadAstronomicalObjectData()
        }
    }
    
    func preloadAstronomicalObjectData() {
        guard let AstronomicalObjectURLPath = Bundle.main.url(forResource: "AstronomicalObjectData", withExtension: "plist") else {
            fatalError("Unableto find astronomical object data path")
        }

        if let rawData = try? Data(contentsOf: AstronomicalObjectURLPath) {
            let decoder = PropertyListDecoder()
            do {
                let decodedData = try decoder.decode([AstroObjUploadModel].self, from: rawData)
                
                let astronomicalObjects = digestAstronomicalObjectData(decodedData: decodedData)
                
                RealmMethods().addAstonomicalObjects(data: astronomicalObjects)
                userDefaultMethods.setUserDefaults(data: true, key: userDefaultMethods.astronomicalObjectPreloadCompletedKey)
                
            } catch {
                print("Error decoding planet info plist: \(error)")
            }
        }
    }

    func digestAstronomicalObjectData(decodedData: [AstroObjUploadModel]) -> [AstronomicalObjectRealm] {
        var astronomicalObjects = [AstronomicalObjectRealm]()

        for (index, object) in decodedData.enumerated() {
            let convertableWeight : Double = Double(object.relativeWeight)/1000000
            let astronomicalObject = AstronomicalObjectRealm()

            astronomicalObject.name = object.name
            astronomicalObject.relativeWeight = convertableWeight
            astronomicalObject.position = index

            astronomicalObjects.append(astronomicalObject)
        }

        return astronomicalObjects
    }
}

