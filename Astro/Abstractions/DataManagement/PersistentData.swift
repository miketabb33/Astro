import UIKit
import CoreData
import RealmSwift

class PersistentData {
    //MARK: - Realm
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
    
    //MARK: - User Defaults
    let initialAPODUploadCompletedKey = "Initial-APOD-Upload-Completed"
    let astronomicalObjectPreloadCompletedKey = "Astronomical-Object-Preload-Completed"
    
    func setUserDefaults(data: Any, key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func getUserDefaultsForBoolean(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    func cleanNasaEntryDatabase() {
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
