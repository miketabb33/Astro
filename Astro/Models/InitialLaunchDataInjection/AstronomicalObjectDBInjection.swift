import Foundation

class AstronomicalObjectDBInjection {
    func uploadUnlessCompleted(isCompleted: Bool) {
        if !isCompleted {
            guard let AstronomicalObjectURLPath = Bundle.main.url(forResource: "AstronomicalObjectData", withExtension: "plist") else {
                fatalError("Unableto find astronomical object data path")
            }

            if let AstronomicalObjectFileData = try? Data(contentsOf: AstronomicalObjectURLPath) {
                let decoder = PropertyListDecoder()
                do {
                    let results = try decoder.decode([AstronomicalObjectModel].self, from: AstronomicalObjectFileData)
                    AstronomicalObjectMethods().createSetOfAstonomicalObjects(set: results)
                    
                    UserDefaultsMethods().setUserDefaults(data: true, key: UserDefaultsMethods().astroObjUploadCompletedKey)
                    
                } catch {
                    print("Error decoding planet info plist: \(error)")
                }
            }
        }
    }
}

