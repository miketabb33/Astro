import UIKit

class FormatterMethods {
    
    func getRelativeWeight(objectRelativeWeight: Double, enteredWeight: Double) -> String {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.maximumFractionDigits = 2

        let relativeWeight = objectRelativeWeight * enteredWeight
        let stringWeight = decimalFormatter.string(from: relativeWeight as NSNumber)
        return "\(stringWeight!) lbs"
    }
    
}


