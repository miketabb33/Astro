import Foundation

struct APODEntryModel {
    var id: Int
    var title: String
    var explanation: String
    var date: String
    var image_url: String
}

struct AstronomicalObjectModel: Decodable {
    var position: Int
    var name: String
    var relativeWeight: Int
}
