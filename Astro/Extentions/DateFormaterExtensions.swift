import UIKit

extension DateFormatter {
    static func convertToDate(yyyyMMdd: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.date(from: yyyyMMdd)!
    }
    
}




