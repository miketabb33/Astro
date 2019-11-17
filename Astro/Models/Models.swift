import Foundation

struct APODEntriesModel: Decodable {
    var entries: [APODEntryModel]
}

struct APODEntryModel: Decodable {
    var id: String
    var image_url: String
    var explanation: String
    var date: String
    var title: String
}

class AstroObjUploadModel : Codable {
    var name  = ""
    var relativeWeight = 0
}
