import Foundation
import RealmSwift

class APODEntryRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var explanation = ""
    @objc dynamic var image_url = ""
    @objc dynamic var title = ""
    @objc dynamic var date = ""
    @objc dynamic var image: Data? = nil
    @objc dynamic var cellHeight = 0
    @objc dynamic var expandEnabled = false
}

class AstronomicalObjectRealm: Object {
    @objc dynamic var name = ""
    @objc dynamic var position = 0
    @objc dynamic var relativeWeight = 0.0
}
