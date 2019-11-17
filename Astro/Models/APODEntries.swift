import Foundation

struct APODItemsModel: Decodable {
    var entries: [APODEntryModel]
}

struct APODEntryModel: Decodable {
    var id: String
    var image_url: String
    var explanation: String
    var date: String
    var title: String
}
