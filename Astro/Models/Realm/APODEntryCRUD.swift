import Foundation
import RealmSwift

class APODEntryRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var explanation = ""
    @objc dynamic var image_url = ""
    @objc dynamic var title = ""
    @objc dynamic var date = Date()
}

class APODEntryCRUD: RealmPath {
    func create(entry: EntryNetworkModel) {
        let newApodEntry = APODEntryRealm()
        newApodEntry.id = Int(entry.id)!
        newApodEntry.title = DecoderMethods().decodeWithUTF8(string: entry.title)
        newApodEntry.explanation = DecoderMethods().decodeWithUTF8(string: entry.explanation)
        newApodEntry.date = FormatterMethods().convertToDate(yyyyMMdd: entry.date)
        newApodEntry.image_url = entry.image_url
        
        try! realm.write {
            realm.add(newApodEntry)
        }
    }
    
    func getAll() -> Results<APODEntryRealm> {
        return realm.objects(APODEntryRealm.self).sorted(byKeyPath: "date",ascending: false)
    }
    
    func get(id: Int) -> APODEntryRealm? {
        return realm.objects(APODEntryRealm.self).filter("id = \(id)").first
    }
    
    func getLastID() -> Int {
        let entries = realm.objects(APODEntryRealm.self)
        let sortedEntries = entries.sorted(byKeyPath: "id",ascending: false)
        
        return sortedEntries.first?.id ?? 0
    }
    
    func getImageURLs(startingIndex: Int, amount: Int) -> [(Int, String)] {
        let APODEntries = getAll()
        var indexAndImageURL = [(Int, String)]()
        
        var i = 0
        while i < amount && startingIndex + i < APODEntries.count {
            let entry = APODEntries[i + startingIndex]
            indexAndImageURL.append((entry.id, entry.image_url))
            
            i += 1
        }
        return indexAndImageURL
        
    }
}
