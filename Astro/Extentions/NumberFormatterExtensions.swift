import Foundation

extension NumberFormatter {
    static func roundTo2DecimalPlaces(number: Double) -> String {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.maximumFractionDigits = 2
        decimalFormatter.minimumFractionDigits = 2

        return decimalFormatter.string(from: number as NSNumber)!
    }
}
