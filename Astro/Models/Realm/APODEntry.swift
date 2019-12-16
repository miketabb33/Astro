import Foundation
import RealmSwift

class APODEntry: Object {
    @objc dynamic var id = 0
    @objc dynamic var explanation = ""
    @objc dynamic var image_url = ""
    @objc dynamic var title = ""
    @objc dynamic var date = Date()
    @objc dynamic var image: Data?
    @objc dynamic var cellHeight = 0
}

class APODEntryMethods: RealmPath {
    func create(entry: EntryNetworkModel) {
        let newApodEntry = APODEntry()
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
        let entries = realm.objects(APODEntry.self)
        let sortedEntries = entries.sorted(byKeyPath: "id",ascending: false)
        
        return sortedEntries.first?.id ?? 0
    }
    
    func getAll() -> Results<APODEntry> {
        return realm.objects(APODEntry.self).sorted(byKeyPath: "date",ascending: false)
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
        var IndexAndImageURL = [(Int, String)]()
        
        var i = 0
        while i < amount && startingIndex + i < APODEntries.count {
            let entry = APODEntries[i + startingIndex]
            IndexAndImageURL.append((entry.id, entry.image_url))
            
            i += 1
        }
        return IndexAndImageURL
        
    }
    
    func entryImageDownloadedCheck(id: Int) -> Bool {
        let entry = realmGet(id: id)
        if entry?.image != nil {
            return true
        } else {
            return false
        }
    }
    
    func realmGet(id: Int) -> APODEntry? {
        let entry = realm.objects(APODEntry.self).filter("id = \(id)").first
        return entry
    }
    
    
    func saveCollectionOfImageDataAndCellHeight(feedDataUpload: [APODFeedDataUpload]) {
        for item in feedDataUpload {
            let realmObj = realmGet(id: item.id)!
            saveImageData(realmObj: realmObj, image: item.image)
            saveCellHeight(realmObj: realmObj, cellHeight: item.cellHeight)
        }
    }
    
    func saveImageData(realmObj: APODEntry, image: Data) {
        try! realm.write {
            realmObj.image = image
        }
    }
    
    func saveCellHeight(realmObj: APODEntry, cellHeight: Int) {
        try! realm.write {
            realmObj.cellHeight = cellHeight
        }
    }
    
}
