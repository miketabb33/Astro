import UIKit

class FormatterMethods {
    
    func roundTo2DecimalPlaces(weight: Double) -> String {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.maximumFractionDigits = 2
        decimalFormatter.minimumFractionDigits = 2

        return decimalFormatter.string(from: weight as NSNumber)!
    }
    
}


