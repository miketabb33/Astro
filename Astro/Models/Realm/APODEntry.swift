import Foundation
import RealmSwift

class APODEntryRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var explanation = ""
    @objc dynamic var image_url = ""
    @objc dynamic var title = ""
    @objc dynamic var date = Date()
    @objc dynamic var image: Data?
    @objc dynamic var cellHeight = 0
}

class APODEntryInteraction: RealmPath {
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
    
    func getLastID() -> Int {
        let entries = realm.objects(APODEntryRealm.self)
        let sortedEntries = entries.sorted(byKeyPath: "id",ascending: false)
        
        return sortedEntries.first?.id ?? 0
    }
    
    func getAll() -> Results<APODEntryRealm> {
        return realm.objects(APODEntryRealm.self).sorted(byKeyPath: "date",ascending: false)
    }
    
    func getPastEntries(startingIndex: Int, amount: Int) -> [APODEntryModel] {
        let APODEntries = getAll()
        var entries = [APODEntryModel]()
        
        var i = 0
        while i < amount && startingIndex + i < APODEntries.count {
            let entry = APODEntries[i + startingIndex]
            entries.append(APODEntryModel(id: entry.id, title: entry.title, explanation: entry.explanation, date: entry.date, image_url: entry.image_url, image: entry.image, cellHeight: entry.cellHeight))
            
            i += 1
        }
        return entries
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
    
    func entryImageDownloadedCheck(id: Int) -> Bool {
        let entry = realmGet(id: id)
        if entry?.image != nil {
            return true
        } else {
            return false
        }
    }
    
    func realmGet(id: Int) -> APODEntryRealm? {
        let entry = realm.objects(APODEntryRealm.self).filter("id = \(id)").first
        return entry
    }
    
    
    func saveCollectionOfImageDataAndCellHeight(feedDataUpload: [APODFeedDataUpload]) {
        for item in feedDataUpload {
            let realmObj = realmGet(id: item.id)!
            saveImageData(realmObj: realmObj, image: item.image)
            saveCellHeight(realmObj: realmObj, cellHeight: item.cellHeight)
        }
    }
    
    func saveImageData(realmObj: APODEntryRealm, image: Data) {
        try! realm.write {
            realmObj.image = image
        }
    }
    
    func saveCellHeight(realmObj: APODEntryRealm, cellHeight: Int) {
        try! realm.write {
            realmObj.cellHeight = cellHeight
        }
    }
    
}
