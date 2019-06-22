import UIKit

class FormatterMethods {
    
    let decimalFormatter = NumberFormatter()
    
    func formatWeight(_ currentPlanet: Planets, enteredWeight: Double?) -> String {
        setToTwoDecimalPlaces()
        var text : String?
        if enteredWeight != nil {
            let weight = ((currentPlanet.relativeWeight! as Decimal) * Decimal(enteredWeight!)) as Any?
            let stringWeight = decimalFormatter.string(from: weight as! NSNumber)
            text = "\(stringWeight!) lbs"
        }
        return text ?? "No Data"
    }
    
    func setToTwoDecimalPlaces(){
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.maximumFractionDigits = 2
    }
    
}
