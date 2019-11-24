import Foundation

struct APODEntryModel {
    var id: Int
    var title: String
    var explanation: String
    var date: Date
    var image_url: String
    var image: Data?
    var cellHeight: Int?
    var expandEnabled: Bool?
}

struct AstronomicalObjectModel: Decodable {
    var position: Int
    var name: String
    var relativeWeight: Int
}
