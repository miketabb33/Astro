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
    func create(id: Int, title: String, explanation: String, date: Date, imageURL: String) {
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
    
    func getAll() -> [APODEntryModel] {
        let APODEntries = realm.objects(APODEntry.self).sorted(byKeyPath: "date",ascending: false)
        
        return APODEntries.map{
            APODEntryModel(id: $0.id, title: $0.title, explanation: $0.explanation, date: $0.date, image_url: $0.image_url, image: $0.image, cellHeight: $0.cellHeight)
        }
    }
    
    func getPastEntries(amount: Int) -> [APODEntryModel] {
        let APODEntries = realm.objects(APODEntry.self).sorted(byKeyPath: "date",ascending: false)
        var container = [APODEntryModel]()
        
        var i = 0
        while i < amount {
            let entry = APODEntries[i]
            container.append(APODEntryModel(id: entry.id, title: entry.title, explanation: entry.explanation, date: entry.date, image_url: entry.image_url, image: entry.image, cellHeight: entry.cellHeight))
            
            i += 1
        }
        return container
    }
    
    func realmGet(id: Int) -> APODEntry? {
        let entry = realm.objects(APODEntry.self).filter("id = \(id)").first
        return entry
    }
    
    func saveImageData(realmObj: APODEntry, entry: APODEntryModel) {
        try! realm.write {
            realmObj.image = entry.image!
        }
    }
    
    func saveCellHeight(realmObj: APODEntry, entry: APODEntryModel) {
        try! realm.write {
            realmObj.cellHeight = entry.cellHeight!
        }
    }
    
    func saveCollectionOfImageDataAndCellHeight(entries: [APODEntryModel]) {
        for entry in entries {
            let realmObj = realmGet(id: entry.id)!
            saveImageData(realmObj: realmObj, entry: entry)
            saveCellHeight(realmObj: realmObj, entry: entry)
        }
    }
    
    
    func cleanAPODDatabase() {
//        let allAPODEntries = getAll()
//        for (index, entry) in allAPODEntries.enumerated() {
//            try! realm.write {
//                if index > 19 {
//                    entry.image = nil
//                }
//                entry.cellHeight = 0
//                entry.expandEnabled = false
//            }
//        }
    }
    
}
