import Foundation
import RealmSwift

class APODFeedDataRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var image = Data()
    @objc dynamic var cellHeight = 0
}

class APODFeedDataInteraction: RealmPath {
    func create(_ feedDataUpload: [APODFeedDataUpload]) {
        for item in feedDataUpload {
            let feedData = APODFeedDataRealm()
            feedData.id = item.id
            feedData.image = item.image
            feedData.cellHeight = item.cellHeight
            
            try! realm.write {
                realm.add(feedData)
            }
        }
    }
}
