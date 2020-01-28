import Foundation
import RealmSwift

class APODFeedDataRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var image = Data()
    @objc dynamic var imageHeight = 0
}

class APODFeedDataCRUD: RealmPath {
    func create(_ feedDataUpload: [APODFeedDataUpload]) {
        for item in feedDataUpload {
            let feedData = APODFeedDataRealm()
            feedData.id = item.id
            feedData.image = item.image
            feedData.imageHeight = item.imageHeight
            
            try! realm.write {
                realm.add(feedData)
            }
        }
    }
    
    
    func getAll() -> Results<APODFeedDataRealm> {
        return realm.objects(APODFeedDataRealm.self).sorted(byKeyPath: "id",ascending: false)
    }
    
    func get(id: Int) -> APODFeedDataRealm? {
        return realm.objects(APODFeedDataRealm.self).filter("id = \(id)").first
    }
}