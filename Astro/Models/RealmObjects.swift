import Foundation
import RealmSwift

class AstronomicalObjectRealm: Object {
    @objc dynamic var name = ""
    @objc dynamic var position = 0
    @objc dynamic var relativeWeight = 0.0
}
