import Foundation
import RealmSwift

class RealmMethods {
    let realm = try! Realm()
    
    func createAPODEntry(entry: APODEntryModel) {
        let newApodEntry = APODEntryRealm()
        newApodEntry.id = Int(entry.id)!
        newApodEntry.title = DecoderMethods().decodeWithUTF8(string: entry.title)
        newApodEntry.explanation = DecoderMethods().decodeWithUTF8(string: entry.explanation)
        newApodEntry.date = entry.date
        newApodEntry.image_url = entry.image_url
        
        try! realm.write {
            realm.add(newApodEntry)
        }
    }
    
    func addAstonomicalObjects(data: [AstronomicalObjectRealm]) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func getLastSavedAPODEntryID() -> Int {
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
