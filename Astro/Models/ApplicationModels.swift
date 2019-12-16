import Foundation

struct APODEntryModel {
    var id: Int
    var title: String
    var explanation: String
    var date: Date
    var image_url: String
    var image: Data?
    var cellHeight: Int?
    var expandEnabled = false
}

struct APODEntry {
    var id: Int
    var contents: Contents
    var feedData: FeedData
}

struct Contents {
    var title: String
    var explanation: String
    var date: Date
    var image_url: String
}

struct FeedData {
    var image: Data
    var cellHeight: Int
    var expandEnabled = false
}

struct AstronomicalObjectModel: Decodable {
    var position: Int
    var name: String
    var relativeWeight: Int
}
