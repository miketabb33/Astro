import UIKit

class SearchBarMethods {
    func resetDisplay(searchBar: UISearchBar, label: UILabel) {
        searchBar.text = ""
        label.text = "Enter Your Weight"
    }
    
    func isValidChecker(enteredText: String, label: UILabel) -> Bool {
        var isSuccess : Bool?
        if Double(enteredText) != nil {
            isSuccess = true
        } else {
            label.text = "Enter a number"
        }
        return isSuccess ?? false
    }
}
