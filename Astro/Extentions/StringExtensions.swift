import Foundation

extension String {
    static func decodeHTMLSymbols(string: String) -> String {
        let data = string.data(using: .utf8)!

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            fatalError("APOD-API data did not decode correctly")
        }

        return attributedString.string
    }
}
