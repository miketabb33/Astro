import Foundation
import RealmSwift

class RealmMethods {
    let realm = try! Realm()
    
    func addAPOD(data: [APODEntryRealm]) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func addAPODEntry(entry: APODEntryRealm) {
        try! realm.write {
            realm.add(entry)
        }
    }
    
    func addAstonomicalObjects(data: [AstronomicalObjectRealm]) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func getLastAPODEntryID() -> Int {
        let entries = realm.objects(APODEntryRealm.self)
        let sortedEntries = entries.sorted(byKeyPath: "id",ascending: false)
        
        return sortedEntries.first?.id ?? 0
    }
    
    func getAllAPODEntries() -> Results<APODEntryRealm> {
        let APODEntries = realm.objects(APODEntryRealm.self)
        let sortedEntries = APODEntries.sorted(byKeyPath: "date",ascending: false)
        return sortedEntries
    }
    
    func getAllAstronomicalObjects() -> Results<AstronomicalObjectRealm> {
        let astronomicalObjects = realm.objects(AstronomicalObjectRealm.self)
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
