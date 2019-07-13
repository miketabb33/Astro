import UIKit

class FormatterMethods {
    
    let decimalFormatter = NumberFormatter()
    
    func formatWeight(_ weight: Decimal) -> String {
        setToTwoDecimalPlaces()
        let stringWeight = decimalFormatter.string(from: weight as NSNumber)
        return "\(stringWeight!) lbs"
    }
    
    private func setToTwoDecimalPlaces(){
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.maximumFractionDigits = 2
    }
    
}


