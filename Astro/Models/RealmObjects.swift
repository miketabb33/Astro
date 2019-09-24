import Foundation
import RealmSwift

class APODEntry: Object {
    @objc dynamic var explanation = ""
    @objc dynamic var url = ""
    @objc dynamic var title = ""
    @objc dynamic var date = ""
}

class AstronomicalObject: Object {
    @objc dynamic var name = ""
    @objc dynamic var position = 0
    @objc dynamic var relativeWeight = 0.0
}
