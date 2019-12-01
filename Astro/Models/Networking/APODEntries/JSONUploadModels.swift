import Foundation

struct APODEntriesJSONModel: Decodable {
    var entries: [APODEntryJSONModel]
}

struct APODEntryJSONModel: Decodable {
    var id: String
    var image_url: String
    var explanation: String
    var date: String
    var title: String
}
