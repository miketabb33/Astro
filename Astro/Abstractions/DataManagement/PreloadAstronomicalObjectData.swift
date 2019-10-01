import Foundation

class PreloadAstronomicalObjectData {
    let persistentData = ()
    
    func preloadAstronomicalObjectsUnlessCompleted() {
        if !persistentData.getUserDefaultsForBoolean(key: persistentData.astronomicalObjectPreloadCompletedKey) {
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
                let decodedData = try decoder.decode([AstronomicalObjectUpload].self, from: rawData)
                
                let astronomicalObjects = digestAstronomicalObjectData(decodedData: decodedData)
                
                persistentData.addAstonomicalObjects(data: astronomicalObjects)
                persistentData.setUserDefaults(data: true, key: persistentData.astronomicalObjectPreloadCompletedKey)
                
            } catch {
                print("Error decoding planet info plist: \(error)")
            }
        }
    }

    func digestAstronomicalObjectData(decodedData: [AstronomicalObjectUpload]) -> [AstronomicalObject] {
        var astronomicalObjects = [AstronomicalObject]()

        for (index, object) in decodedData.enumerated() {
            let convertableWeight : Double = Double(object.relativeWeight)/1000000
            let astronomicalObject = AstronomicalObject()

            astronomicalObject.name = object.name
            astronomicalObject.relativeWeight = convertableWeight
            astronomicalObject.position = index

            astronomicalObjects.append(astronomicalObject)
        }

        return astronomicalObjects
    }
}

