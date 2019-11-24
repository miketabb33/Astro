import UIKit

class FormatterMethods {
    
    func roundTo2DecimalPlaces(weight: Double) -> String {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.maximumFractionDigits = 2
        decimalFormatter.minimumFractionDigits = 2

        return decimalFormatter.string(from: weight as NSNumber)!
    }
    
    func convertToDate(yyyyMMdd: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.date(from: yyyyMMdd)!
    }
    
    
}


