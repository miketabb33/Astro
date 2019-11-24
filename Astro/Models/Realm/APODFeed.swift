import Foundation
import RealmSwift

class APODFeedEntryRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var image = Data()
    @objc dynamic var cellHeight = 0
}

class APODFeedEntryMethods: RealmPath {
    func create(id: Int, image: Data, cellHeight: Int) {
        let newAPODFeedEntry = APODFeedEntryRealm()
        newAPODFeedEntry.id = id
        newAPODFeedEntry.image = image
        newAPODFeedEntry.cellHeight = cellHeight
        
        try! realm.write {
            realm.add(newAPODFeedEntry)
        }
    }
}
