import Foundation
import RealmSwift

class APODEntry: Object {
    @objc dynamic var id = 0
    @objc dynamic var explanation = ""
    @objc dynamic var image_url = ""
    @objc dynamic var title = ""
    @objc dynamic var date = ""
    @objc dynamic var image: Data? = nil
    @objc dynamic var cellHeight = 0
    @objc dynamic var expandEnabled = false
}

class APODEntryMethods: RealmPath {
    func create(id: Int, title: String, explanation: String, date: String, imageURL: String) {
        let newApodEntry = APODEntry()
        newApodEntry.id = id
        newApodEntry.title = title
        newApodEntry.explanation = explanation
        newApodEntry.date = date
        newApodEntry.image_url = imageURL
        
        try! realm.write {
            realm.add(newApodEntry)
        }
    }
    
    func getLastID() -> Int {
        let entries = realm.objects(APODEntry.self)
        let sortedEntries = entries.sorted(byKeyPath: "id",ascending: false)
        
        return sortedEntries.first?.id ?? 0
    }
    
    func getAll() -> Results<APODEntry> {
        let APODEntries = realm.objects(APODEntry.self)
        let sortedEntries = APODEntries.sorted(byKeyPath: "date",ascending: false)
        return sortedEntries
    }
    
    
    func cleanAPODDatabase() {
        let allAPODEntries = getAll()
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
