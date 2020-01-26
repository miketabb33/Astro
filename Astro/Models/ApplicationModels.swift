import UIKit

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
    var cellHeight: CellHeight
    var expandEnabled = false
}

class CellHeight {
    var title: CGFloat
    var image: CGFloat
    var explanation: CGFloat
    var expandButtonView: CGFloat
    
    init(title: CGFloat, image: Int, explanation: CGFloat, expandButtonView: CGFloat) {
        self.title = title
        self.image = CGFloat(image)
        self.explanation = explanation
        self.expandButtonView = expandButtonView
    }
    
    func total() -> CGFloat {
        return title + image + explanation + expandButtonView
    }
}

struct AstronomicalObjectModel: Decodable {
    var position: Int
    var name: String
    var relativeWeight: Int
}
