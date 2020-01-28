import Foundation
import RealmSwift

class AstronomicalObjectRealm: Object {
    @objc dynamic var name = ""
    @objc dynamic var position = 0
    @objc dynamic var relativeWeight = 0.0
}

class AstronomicalObjectCRUD: RealmPath {
    func createAstronomicalObject(position: Int, name: String, relativeWeight: Int) {
        let newAstronomicalObject = AstronomicalObjectRealm()
        newAstronomicalObject.position = position
        newAstronomicalObject.name = name
        newAstronomicalObject.relativeWeight = Double(relativeWeight)/1000000
        
        try! realm.write {
            realm.add(newAstronomicalObject)
        }
    }
    
    func createSetOfAstonomicalObjects(set: [AstronomicalObjectModel]) {
        for item in set {
            createAstronomicalObject(position: item.position, name: item.name, relativeWeight: item.relativeWeight)
        }
    }
    
    
    func getAllAstronomicalObjects() -> Results<AstronomicalObjectRealm> {
        let astronomicalObjects = realm.objects(AstronomicalObjectRealm.self)
        let sortedObjects = astronomicalObjects.sorted(byKeyPath: "position",ascending: true)
        return sortedObjects
    }
}
