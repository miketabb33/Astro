import UIKit

class SearchBarValidation {
    var searchBar: UISearchBar
    
    init(searchBar: UISearchBar) {
        self.searchBar = searchBar
    }
    
    func validateDouble(onSuccess: String ,onFailure: String) -> String {
        if Double(searchBar.text!) == nil {
            return onFailure
        }
        return onSuccess
    }
    
}
