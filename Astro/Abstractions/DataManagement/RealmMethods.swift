import Foundation
import RealmSwift

class RealmMethods {
    let realm = try! Realm()
    
    func addAPOD(data: [APODEntry]) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func addAstonomicalObjects(data: [AstronomicalObject]) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func getLastAPODEntry() -> APODEntry {
        let entries = realm.objects(APODEntry.self)
        let sortedEntries = entries.sorted(byKeyPath: "date",ascending: false)
        
        return sortedEntries.first!
    }
    
    func getAllAPODEntries() -> Results<APODEntry> {
        let APODEntries = realm.objects(APODEntry.self)
        let sortedEntries = APODEntries.sorted(byKeyPath: "date",ascending: false)
        return sortedEntries
    }
    
    func getAllAstronomicalObjects() -> Results<AstronomicalObject> {
        let astronomicalObjects = realm.objects(AstronomicalObject.self)
        let sortedObjects = astronomicalObjects.sorted(byKeyPath: "position",ascending: true)
        return sortedObjects
    }
    
    func cleanAPODDatabase() {
        let allAPODEntries = getAllAPODEntries()
        for (index, entry) in allAPODEntries.enumerated() {
            try! realm.write {
                if index > 19 {
                    entry.image = nil
                }
                entry.cellHeight = 0
                entry.expandEnabled = false
            }
        }
    }
}
