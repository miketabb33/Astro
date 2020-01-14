import Foundation

struct EntriesNetworkModel: Decodable {
    var entries: [EntryNetworkModel]
}

struct EntryNetworkModel: Decodable {
    var id: String
    var image_url: String
    var explanation: String
    var date: String
    var title: String
}

struct APODFeedDataUpload {
    var id: Int
    var image: Data
    var imageHeight: Int
    var cellHeight: Int
}
