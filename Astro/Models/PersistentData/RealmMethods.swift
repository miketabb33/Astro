import Foundation
import RealmSwift

class RealmMethods {
    let realm = try! Realm()
    
    func createAPODEntry(apodEntry: APODEntryModel) {
        let newApodEntry = APODEntryRealm()
        newApodEntry.id = Int(apodEntry.id)!
        newApodEntry.title = DecoderMethods().decodeWithUTF8(string: apodEntry.title)
        newApodEntry.explanation = DecoderMethods().decodeWithUTF8(string: apodEntry.explanation)
        newApodEntry.date = apodEntry.date
        newApodEntry.image_url = apodEntry.image_url
        
        try! realm.write {
            realm.add(newApodEntry)
        }
    }
    
    func createAstronomicalObject(position: Int, name: String, relativeWeight: Int) {
        let newAstronomicalObject = AstronomicalObjectRealm()
        newAstronomicalObject.position = position
        newAstronomicalObject.name = name
        newAstronomicalObject.relativeWeight = Double(relativeWeight)/1000000
        
        try! realm.write {
            realm.add(newAstronomicalObject)
        }
    }
    
    func createSetOfAstonomicalObjects(set: [AstroObjUploadModel]) {
        for item in set {
            createAstronomicalObject(position: item.position, name: item.name, relativeWeight: item.relativeWeight)
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
