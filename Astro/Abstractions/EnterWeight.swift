import UIKit

class EnterWeight {
    
    let decimalFormatter = NumberFormatter()
    
    func resetDisplay(searchBar: UISearchBar, label: UILabel) {
        searchBar.text = ""
        label.text = "Enter Your Weight"
    }
    
    func isValidChecker(enteredText: String, label: UILabel) -> Bool {
        var isSuccess = false
        if Double(enteredText) != nil {
            isSuccess = true
        } else {
            label.text = "Enter a number"
        }
        return isSuccess
    }
    
    func attemptSegue(_ bool: Bool, SendingVC: UIViewController) {
        if bool {
            SendingVC.performSegue(withIdentifier: "goToPlanetWeightScreen", sender: self)
        }
    }
    
    func formatWeight(_ currentPlanet: Planets, enteredWeight: Double?) -> String {
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.maximumFractionDigits = 2
        var cellText = "No Data"
        if enteredWeight != nil {
            let weight = ((currentPlanet.relativeWeight! as Decimal) * Decimal(enteredWeight!)) as Any?
            if let value = weight {
                let stringWeight = decimalFormatter.string(from: value as! NSNumber)
                 cellText = "\(stringWeight!) lbs"
            }
        }
        return cellText
    }
    
}
