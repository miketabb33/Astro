import UIKit

class SearchBarMethods {
    var searchBar: UISearchBar
    
    init(_ searchBar: UISearchBar) {
        self.searchBar = searchBar
    }
    
    func getValidationMessageForDouble(onSuccess: String, onFailure: String) -> String {
        if Double(searchBar.text!) == nil {
            return onFailure
        } else {
            return onSuccess
        }
    }
    
}
